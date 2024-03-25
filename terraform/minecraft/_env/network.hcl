terraform {
    source = "../../../../../_modules//network"
}

inputs = {
    open_port_ranges = {
        game = [25565, 25565]
    }
}
