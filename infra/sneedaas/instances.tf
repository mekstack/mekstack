resource "openstack_compute_instance_v2" "instance" {
  count = 3

  name            = "${var.name}-${count.index + 1}"
  image_id        = var.image_id
  flavor_name     = "m2s.micro"
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]
  user_data       = file("${path.module}/user-data.yaml")

  network {
    uuid        = openstack_networking_network_v2.network.id
    fixed_ip_v4 = "10.0.0.${count.index + 11}"
  }

  depends_on = [openstack_networking_subnet_v2.subnet]
}
