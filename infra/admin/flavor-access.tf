resource "openstack_compute_flavor_v2" "drone" {
  name      = "drone"
  vcpus     = 8
  ram       = 6144
  swap      = 2048
  disk      = 30
  is_public = false

  extra_specs = {
    "hw:numa_nodes" = 1,
    "hw:cpu_policy" = "shared"
  }
}

resource "openstack_compute_flavor_access_v2" "drone" {
  tenant_id = openstack_identity_project_v3.drone.id
  flavor_id = openstack_compute_flavor_v2.drone.id
}
