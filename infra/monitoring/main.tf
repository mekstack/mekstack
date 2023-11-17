provider "openstack" {
  cloud = "openstack"
}
resource "openstack_compute_servergroup_v2" "servergroup" {
  name     = "secgroup"
  policies = ["anti-affinity"]
}
resource "openstack_compute_instance_v2" "instance" {
  count = 1
  name            = var.name
  image_id        = var.image_id
  flavor_name     = "m2s.small"
  key_pair        = var.key_pair
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    uuid        = openstack_networking_network_v2.network.id
    fixed_ip_v4 = "10.0.0.${count.index + 11}"
  }
  scheduler_hints {
    group = openstack_compute_servergroup_v2.servergroup.id
  }
  depends_on = [openstack_networking_subnet_v2.subnet]
}