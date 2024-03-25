locals {
    aws_region = "us-west-2"
    
    default_tags = {
        "minecraft:region" = local.aws_region
    }
}
