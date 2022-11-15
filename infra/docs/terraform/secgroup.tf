locals {
  tcp_ports = ["22", "80"]
}

resource "openstack_networking_secgroup_v2" "secgroup" {
  name = local.project
}

resource "openstack_networking_secgroup_rule_v2" "tcp" {
  for_each = toset(local.tcp_ports)

  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = each.key
  port_range_max    = each.key
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}
