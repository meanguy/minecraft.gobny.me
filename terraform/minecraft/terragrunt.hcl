locals {
    account_config = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    environment_config = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
    region_config = read_terragrunt_config(find_in_parent_folders("region.hcl"))

    account_name = local.account_config.locals.account_name
    account_id = local.account_config.locals.aws_account_id
    aws_region = local.region_config.locals.aws_region
    stage_name = local.environment_config.locals.stage_name

    default_tags = {
        "minecraft:module": "${path_relative_to_include()}"
    }

    all_default_tags = merge(
        local.default_tags,
        local.account_config.locals.default_tags,
        local.environment_config.locals.default_tags,
        local.region_config.locals.default_tags,
    )
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<EOF
provider "aws" {
    region = "${local.aws_region}"

    allowed_account_ids = ["${local.account_id}"]
}
EOF
}

remote_state {
    backend = "s3"
    config = {
        encrypt = true
        bucket = "minecraft-server-terraform-state-${local.account_name}-${local.account_id}"
        key = "${path_relative_to_include()}/terraform.tfstate"
        region = local.aws_region
        dynamodb_table = "terraform-locks"
    }

    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}

inputs = merge(
    local.account_config.locals,
    local.environment_config.locals,
    local.region_config.locals,
    {
        default_tags = local.all_default_tags
    }
)
