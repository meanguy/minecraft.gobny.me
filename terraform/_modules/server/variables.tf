variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-west-2)"
  type        = string
}

variable "default_tags" {
  description = "The default tag values to apply to resources"
  type        = map(string)
}

variable "image_id" {
  description = "The Amazon Image ID to deploy (e.g. ami-04aa685cc800320b3)"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type to deploy (e.g. t3.small)"
}

variable "name_prefix" {
  description = "The name prefix used for namespacing resources"
  type        = string
}

variable "network_interface_id" {
  description = "The network interface to attach to the instance"
  type        = string
}

variable "root_zone" {
  description = "The Route53 Hosted Zone to contain DNS records"
  type = object({
    id   = string
    name = string
  })
}

variable "subdomain" {
  description = "The subdomain to use when creating DNS records"
  type        = string
}

variable "volume_id" {
  description = "The EBS volume with the game world server data"
  type        = string
}
