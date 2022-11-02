resource "openstack_compute_instance_v2" "master" {
  name        = "master"
  image_name  = "Arch Linux"
  flavor_name = "m2s.medium"
  key_pair    = "admins"
  network {
    name = "miem"
  }
  security_groups = ["default"]
}

resource "openstack_compute_instance_v2" "exec1" {
  name        = "exec1"
  image_name  = "Arch Linux"
  flavor_name = "m2s.colossal"
  key_pair    = "admins"
  network {
    name = "miem"
  }
  security_groups = ["default"]
}
