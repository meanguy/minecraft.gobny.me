terraform {
    source = "../../../../../_modules//data"
}

dependency "network" {
    config_path = "../network"
}

inputs = {
    availability_zone = dependency.network.outputs.availability_zones[0]
}
