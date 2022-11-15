resource "openstack_compute_instance_v2" "instance" {
  for_each = toset(local.instances)

  name            = each.key
  image_name      = "Ubuntu focal"
  flavor_name     = "m2s.micro"
  key_pair        = openstack_compute_keypair_v2.all.name
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    uuid        = openstack_networking_network_v2.network.id
    fixed_ip_v4 = "10.69.69.${index(local.instances, each.key) + 10}"
  }
}
