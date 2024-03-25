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
    image_id = "ami-01b6747a7dc66d8a5"
    instance_type = "c6i.xlarge"
}
