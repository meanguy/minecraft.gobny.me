variable "default_tags" {
  description = "The default tag values to apply to resources"
  type        = map(string)
}

variable "max_availability_zones" {
  description = "The maximum number of availablity zones to consider for deployment"
  type        = number
}

variable "name_prefix" {
  description = "The name prefix used for namespacing resources"
  type        = string
}

variable "open_port_ranges" {
  description = "The port ranges used by the game server which should be open"
  type        = map(tuple([number, number]))
}

variable "root_zone_name" {
  description = "The root domain name for creating DNS records under"
  type        = string
}

variable "vpc_id" {
  description = "The AWS VPC to deploy to (e.g. vpc-1234567890abcdefg)"
  type        = string
}
