packer {
    required_plugins {
        amazon = {
            source = "github.com/hashicorp/amazon"
            version = "~> 1"
        }
        ansible = {
            source = "github.com/hashicorp/ansible"
            version = "~> 1"
        }
    }
}

data "amazon-secretsmanager" "datadog" {
    name = "gobny/${var.environment}/apikeys"
    key = "datadog"

    region = var.aws_region
}

data "amazon-secretsmanager" "rcon_password" {
    name = "gobny/${var.environment}/rcon"
    key = "password"

    region = var.aws_region
}

local "datadog" {
    expression = "${data.amazon-secretsmanager.datadog.value}"

    sensitive = true
}

local "rcon_password" {
    expression = "${data.amazon-secretsmanager.rcon_password.value}"

    sensitive = true
}

locals {
    ansible_extra_vars = {
        api_keys = {
            datadog = jsondecode(local.datadog)
        }
        env = var.environment
        minecraft_rcon_password = local.rcon_password
        region = var.aws_region
    }
}

source "amazon-ebs" "minecraft" {
    ami_name = "minecraft-${formatdate("YYYYMMDDhhmm", timestamp())}"

    ami_virtualization_type = "hvm"
    instance_type = "t3.medium"
    ssh_username = "ubuntu"

    region = var.aws_region
    skip_create_ami = var.enable_dryrun

    launch_block_device_mappings {
        device_name = "/dev/sda1"
        volume_size = 20
        volume_type = "gp3"
        delete_on_termination = true
    } 

    source_ami_filter {
        filters = {
            name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
            root-device-type = "ebs"
            virtualization-type = "hvm"
        }

        most_recent = true
        owners = ["099720109477"]
    }
}


build {
    name = "minecraft"

    sources = [
        "source.amazon-ebs.minecraft"
    ]

    provisioner "shell" {
        inline = [
            "cloud-init status --wait",
        ]
    }

    provisioner "ansible" {
        playbook_file = "playbooks/minecraft.yml"
        host_alias = var.environment
        extra_arguments = [
            "--extra-vars=${jsonencode(local.ansible_extra_vars)}",
        ]
        use_proxy = false
    }

    post-processor "manifest" {
        output = "${var.build_directory}/manifest.${var.environment}.json"
    }
}
