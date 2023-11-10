resource "openstack_compute_quotaset_v2" "admin" {
  project_id           = data.openstack_identity_auth_scope_v3.current.project_id
  key_pairs            = 10
  ram                  = 100000
  cores                = 300
  instances            = 20
  server_groups        = 20
  server_group_members = 80
}

resource "openstack_blockstorage_quotaset_v3" "admin" {
  project_id           = data.openstack_identity_auth_scope_v3.current.project_id
  volumes              = 30
  snapshots            = 30
  gigabytes            = 10000
  per_volume_gigabytes = 1000
  backups              = 30
  backup_gigabytes     = 1000
  groups               = 100
}

resource "openstack_networking_quota_v2" "quota_1" {
  project_id          = data.openstack_identity_auth_scope_v3.current.project_id
  floatingip          = 20
  network             = 10
  port                = 100
  rbac_policy         = 10
  router              = 10
  security_group      = 20
  security_group_rule = 200
  subnet              = 20
  subnetpool          = 10
}
