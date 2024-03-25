resource "aws_eip" "eip" {
  domain = "vpc"

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-eip"
  })
}

resource "aws_iam_policy" "instance" {
  name   = "${var.name_prefix}-instance-policy"
  policy = data.aws_iam_policy_document.instance_role.json
}

resource "aws_iam_role" "instance" {
  name = "${var.name_prefix}-instance-role"
  path = "/"

  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = [aws_iam_policy.instance.arn]
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.name_prefix}-instance-profile"
  role = aws_iam_role.instance.name
}

resource "aws_instance" "minecraft" {
  ami           = var.image_id
  instance_type = var.instance_type

  monitoring = true

  iam_instance_profile = resource.aws_iam_instance_profile.profile.name

  network_interface {
    network_interface_id = var.network_interface_id

    device_index = 0
  }

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-instance"
  })
}

resource "aws_eip_association" "assoc" {
  allocation_id = aws_eip.eip.id

  network_interface_id = var.network_interface_id
}

resource "aws_volume_attachment" "volume" {
  device_name = "/dev/sdh"

  instance_id = aws_instance.minecraft.id
  volume_id   = var.volume_id
}

resource "aws_route53_record" "record" {
  zone_id = var.root_zone.id
  name    = "${var.subdomain}.${var.root_zone.name}"

  type    = "A"
  ttl     = 300
  records = [aws_eip.eip.public_ip]
}
