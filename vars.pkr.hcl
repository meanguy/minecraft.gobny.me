variable "aws_region" {
    default = "us-west-2"
    description = "The AWS region to deploy to"
    type = string
}

variable "build_directory" {
    default = "_build"
    description = "The directory where the build artifacts are stored"
    type = string
}

variable "enable_dryrun" {
    default = true
    description = "Whether to save the AMI after building the image"
    type = bool
}

variable "environment" {
    default = "ptr"
    description = "The environment to deploy to"
    type = string
}
