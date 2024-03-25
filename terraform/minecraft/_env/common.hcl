locals {
    environment_config = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

    stage_name = local.environment_config.locals.stage_name
}

inputs = {
    name_prefix = "minecraft-server-${local.stage_name}"
}