include "root" {
    path = find_in_parent_folders()
}

include "common" {
    path = "${dirname(find_in_parent_folders())}/_env/common.hcl"
}

include "env" {
    path = "${dirname(find_in_parent_folders())}/_env/server.hcl"
}

inputs = {
    image_id = "ami-06ba3cbb6f817839e"
    instance_type = "c6i.xlarge"
}
