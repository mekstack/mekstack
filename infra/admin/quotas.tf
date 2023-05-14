resource "openstack_compute_quotaset_v2" "admin" {
  project_id           = data.openstack_identity_auth_scope_v3.current.project_id
  key_pairs            = 10
  ram                  = 1000000
  cores                = 300
  instances            = 20
  server_groups        = 4
  server_group_members = 8
}

resource "openstack_blockstorage_quotaset_v3" "admin" {
  project_id           = data.openstack_identity_auth_scope_v3.current.project_id
  volumes              = 20
  snapshots            = 20
  gigabytes            = 10000
  per_volume_gigabytes = 1000
  backups              = 20
  backup_gigabytes     = 1000
  groups               = 100
}
