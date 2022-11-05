resource "openstack_compute_instance_v2" "web-1" {
  name        = "web-1"
  image_name  = "Arch Linux"
  flavor_name = "m2s.micro"
  key_pair    =  openstack_compute_keypair_v2.admin-deploy.name
  network {
    name  = "miem"
  }
  security_groups = ["default"]
}

resource "openstack_compute_instance_v2" "web-2" {
  name        = "web-2"
  image_name  = "Arch Linux"
  flavor_name = "m2s.micro"
  key_pair    =  openstack_compute_keypair_v2.admin-deploy.name
  network {
    name = "miem"
  }
  security_groups = ["default"]
}
