variable "availability_zone" {
  description = "The availability zone for the instance"
  default     = "us-west-2a"
  type        = string
}

variable "default_tags" {
  description = "A map of tags to apply to all resources"
  default     = {}
  type        = map(string)
}

variable "name_prefix" {
  description = "A prefix to apply to all names"
  type        = string
}

variable "volume_size_gb" {
  description = "The size of the volume in GB"
  default     = 8
  type        = number
}
