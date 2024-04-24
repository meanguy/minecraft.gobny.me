include "root" {
    path = find_in_parent_folders()
}

include "common" {
    path = "${dirname(find_in_parent_folders())}/_env/common.hcl"
}

include "env" {
    path = "${dirname(find_in_parent_folders())}/_env/data.hcl"
}

inputs = {
    volume_size_gb = 8
}
