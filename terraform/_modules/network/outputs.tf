output "availability_zones" {
  value = local.availability_zones
}

output "network_interface_ids" {
  value = {
    for zone in local.availability_zones :
    zone => aws_network_interface.nic[zone].id
  }
}

output "subnet_ids" {
  value = {
    for zone in local.availability_zones :
    zone => data.aws_subnet.subnet[zone].id
  }
}

output "root_zone" {
  value = {
    id   = data.aws_route53_zone.zone.id
    name = data.aws_route53_zone.zone.name
  }
}
