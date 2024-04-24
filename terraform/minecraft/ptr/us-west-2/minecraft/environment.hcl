locals {
    stage_name = "ptr"
    vpc_id = "vpc-077d99d0623a6aabb"

    default_tags = {
        "minecraft:stage" = local.stage_name
    }
}
