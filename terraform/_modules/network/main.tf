locals {
  num_availability_zones = min(var.max_availability_zones, length(data.aws_availability_zones.available.names))
  availability_zones     = slice(data.aws_availability_zones.available.names, 0, local.num_availability_zones)
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_route53_zone" "zone" {
  name = var.root_zone_name
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "subnet-id"
    values = data.aws_subnets.subnets.ids
  }

  for_each = toset(local.availability_zones)
}

resource "aws_security_group" "nic-sg" {
  name   = "${var.name_prefix}-nic-sg"
  vpc_id = var.vpc_id

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-nic-sg"
  })
}

resource "aws_network_interface" "nic" {
  security_groups = [aws_security_group.nic-sg.id]

  subnet_id = data.aws_subnet.subnet[each.key].id

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-nic-${each.key}"
  })

  for_each = toset(local.availability_zones)
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.nic-sg.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_v6" {
  security_group_id = aws_security_group.nic-sg.id

  ip_protocol = "-1"

  cidr_ipv6 = "::/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.nic-sg.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_v6" {
  security_group_id = aws_security_group.nic-sg.id

  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  cidr_ipv6 = "::/0"
}

resource "aws_vpc_security_group_ingress_rule" "allowed_tcp" {
  security_group_id = aws_security_group.nic-sg.id

  from_port   = each.value[0]
  to_port     = each.value[1]
  ip_protocol = "tcp"

  cidr_ipv4 = "0.0.0.0/0"

  for_each = var.open_port_ranges
}

resource "aws_vpc_security_group_ingress_rule" "allowed_tcp_v6" {
  security_group_id = aws_security_group.nic-sg.id

  from_port   = each.value[0]
  to_port     = each.value[1]
  ip_protocol = "tcp"

  cidr_ipv6 = "::/0"

  for_each = var.open_port_ranges
}

resource "aws_vpc_security_group_ingress_rule" "allowed_udp" {
  security_group_id = aws_security_group.nic-sg.id

  from_port   = each.value[0]
  to_port     = each.value[1]
  ip_protocol = "udp"

  cidr_ipv4 = "0.0.0.0/0"

  for_each = var.open_port_ranges
}

resource "aws_vpc_security_group_ingress_rule" "allowed_udp_v6" {
  security_group_id = aws_security_group.nic-sg.id

  from_port   = each.value[0]
  to_port     = each.value[1]
  ip_protocol = "udp"

  cidr_ipv6 = "::/0"

  for_each = var.open_port_ranges
}