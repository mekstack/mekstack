resource "openstack_networking_floatingip_v2" "master-fip" {
  pool = "miem"
}

resource "openstack_networking_floatingip_v2" "exec1-fip" {
  pool = "miem"
}

resource "openstack_compute_floatingip_associate_v2" "master-fip" {
  floating_ip = openstack_networking_floatingip_v2.master-fip.address
  instance_id = openstack_compute_instance_v2.master.id
}

resource "openstack_compute_floatingip_associate_v2" "exec1-fip" {
  floating_ip = openstack_networking_floatingip_v2.exec1-fip.address
  instance_id = openstack_compute_instance_v2.exec1.id
}

resource "openstack_compute_instance_v2" "master" {
  name        = "master"
  image_name  = "Arch Linux with Docker"
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
