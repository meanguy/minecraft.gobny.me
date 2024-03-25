terraform {
    source = "../../../../../_modules//network"
}

inputs = {
    open_port_ranges = {
        dynamp = [8123, 8123]
        game = [25565, 25565]
    }
}
