resource "openstack_compute_instance_v2" "web-1" {
  name        = "web-1"
  image_name  = "Arch Linux"
  flavor_name = "m2s.micro"
  key_pair    =  openstack_compute_keypair_v2.admin-deploy.public_key
  network {
    uuid = openstack_networking_network_v2.network.id
  }
  security_groups = ["default"]
}

resource "openstack_compute_floatingip_associate_v2" "web-1" {
  floating_ip = openstack_networking_floatingip_v2.web-1.address
  instance_id = openstack_compute_instance_v2.web-1.id
}

resource "openstack_compute_instance_v2" "web-2" {
  name        = "web-2"
  image_name  = "Arch Linux"
  flavor_name = "m2s.micro"
  key_pair    =  openstack_compute_keypair_v2.admin-deploy.public_key
  network {
    uuid = openstack_networking_network_v2.network.id
  }
  security_groups = ["default"]
}

resource "openstack_compute_floatingip_associate_v2" "web-2" {
  floating_ip = openstack_networking_floatingip_v2.web-2.address
  instance_id = openstack_compute_instance_v2.web-2.id
}
