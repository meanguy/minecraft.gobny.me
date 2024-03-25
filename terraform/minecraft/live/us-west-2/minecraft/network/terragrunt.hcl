include "root" {
    path = find_in_parent_folders()
}

include "common" {
    path = "${dirname(find_in_parent_folders())}/_env/common.hcl"
}

include "env" {
    path = "${dirname(find_in_parent_folders())}/_env/network.hcl"
}

inputs = {
    max_availability_zones = 1
    root_zone_name = "live.gobny.me"
}
