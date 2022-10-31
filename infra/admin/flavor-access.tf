data "openstack_identity_project_v3" "drone" {
  name = "drone"
}

resource "openstack_compute_flavor_access_v2" "m2s_colossal_for_drone" {
  tenant_id = data.openstack_identity_project_v3.drone.id
  flavor_id = openstack_compute_flavor_v2.m2s_colossal.id
}
