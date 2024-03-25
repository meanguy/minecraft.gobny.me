locals {
    account_name = "live"
    aws_account_id = "304783710577"
    
    default_tags = {
        "minecraft:account" = local.account_name
    }
}
