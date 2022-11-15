resource "openstack_compute_quotaset_v2" "drone_quota" {
  project_id           = openstack_identity_project_v3.drone.id
  key_pairs            = 10
  ram                  = 6144
  cores                = 20
  instances            = 5
  server_groups        = 4
  server_group_members = 8
}
