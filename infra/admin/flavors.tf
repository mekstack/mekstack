resource "openstack_compute_flavor_v2" "m2s_micro" {
  name      = "m2s.micro"
  vcpus     = "4"
  ram       = "512"
  swap      = "512"
  disk      = "5"
  is_public = true
  flavor_id = "8d094682-640b-46d0-97a7-7c39b60a8679"

  extra_specs = {
    "hw:numa_nodes" = 1,
    "hw:cpu_policy" = "shared"
  }
}

resource "openstack_compute_flavor_v2" "m2s_small" {
  name      = "m2s.small"
  vcpus     = "6"
  ram       = "512"
  swap      = "512"
  disk      = "10"
  is_public = true
  flavor_id = "1d0cdea6-2c79-4743-aa4f-4b620d443fe5"

  extra_specs = {
    "hw:numa_nodes" = 1,
    "hw:cpu_policy" = "shared"
  }
}

resource "openstack_compute_flavor_v2" "m2s_medium" {
  name      = "m2s.medium"
  vcpus     = "6"
  ram       = "1024"
  swap      = "1024"
  disk      = "15"
  is_public = true
  flavor_id = "d05c7f26-ae72-4422-a1fe-d28c421e7987"

  extra_specs = {
    "hw:numa_nodes" = 1,
    "hw:cpu_policy" = "shared"
  }
}

resource "openstack_compute_flavor_v2" "m2s_large" {
  name      = "m2s.large"
  vcpus     = "8"
  ram       = "2048"
  swap      = "1024"
  disk      = "20"
  is_public = true

  flavor_id = "70b424dc-c77a-4d4d-8225-c45153f493d7"

  extra_specs = {
    "hw:numa_nodes" = 1,
    "hw:cpu_policy" = "shared"
  }
}

resource "openstack_compute_flavor_v2" "m2s_colossal" {
  name      = "m2s.colossal"
  vcpus     = "8"
  ram       = "5120"
  swap      = "2048"
  disk      = "20"
  is_public = false
  flavor_id = "e49317fe-ca94-aa76-9a5d-a309864655bf"

  extra_specs = {
    "hw:numa_nodes" = 1,
    "hw:cpu_policy" = "shared"
  }
}
