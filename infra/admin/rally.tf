resource "openstack_identity_project_v3" "rally" {
  name        = "rally"
  description = "Project for rally tests"
}

resource "openstack_compute_flavor_v2" "m1_tiny" {
  name      = "m1.tiny"
  vcpus     = "2"
  ram       = "64"
  disk      = "1"
  is_public = false
  flavor_id = "191f257e-9355-49b7-b0df-0b3a4d14b149"
}

resource "openstack_compute_flavor_access_v2" "m1_tiny_rally" {
  tenant_id = openstack_identity_project_v3.rally.id
  flavor_id = openstack_compute_flavor_v2.m1_tiny.id
}

resource "openstack_images_image_v2" "cirros" {
  name             = "cirros-0.5.1-x86_64-disk"
  image_source_url = "http://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "shared"
}

resource "openstack_images_image_access_v2" "cirros_rally" {
  image_id  = openstack_images_image_v2.cirros.id
  member_id = openstack_identity_project_v3.rally.id
  status    = "accepted"
}

resource "openstack_identity_user_v3" "tester1" {
  default_project_id = openstack_identity_project_v3.rally.id
  name               = "tester1"
  description        = "Test account for rally"
  # password = "password123"
  ignore_change_password_upon_first_use = true
}

resource "openstack_identity_user_v3" "tester2" {
  default_project_id = openstack_identity_project_v3.rally.id
  name               = "tester2"
  description        = "Test account for rally"
  # password = "password123"
  ignore_change_password_upon_first_use = true
}

resource "openstack_identity_user_v3" "tester3" {
  default_project_id = openstack_identity_project_v3.rally.id
  name               = "tester3"
  description        = "Test account for rally"
  # password = "password123"
  ignore_change_password_upon_first_use = true
}

resource "openstack_compute_quotaset_v2" "rally" {
  project_id           = openstack_identity_project_v3.rally.id
  key_pairs            = 20
  ram                  = 40960
  cores                = 32
  instances            = 30
  server_groups        = 40
  server_group_members = 80
}

resource "openstack_networking_quota_v2" "rally" {
  project_id          = openstack_identity_project_v3.rally.id
  floatingip          = 30
  network             = 10
  port                = 200
  rbac_policy         = 20
  router              = 10
  security_group      = 50
  security_group_rule = 200
  subnet              = 10
  subnetpool          = 10
}
