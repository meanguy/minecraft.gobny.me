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
    image_id = "ami-0c911822af0ca1f7a"
    instance_type = "c6i.xlarge"
}
