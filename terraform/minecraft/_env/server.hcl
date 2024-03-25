terraform {
    source = "../../../../../_modules//server"
}

dependency "network" {
    config_path = "../network"
}

dependency "data" {
    config_path = "../data"
}

inputs = {
    network_interface_id = dependency.network.outputs.network_interface_ids[dependency.data.outputs.availability_zone]
    root_zone = dependency.network.outputs.root_zone
    volume_id = dependency.data.outputs.volume_id

    subdomain = "minecraft"
}
