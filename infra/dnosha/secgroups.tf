resource "openstack_networking_secgroup_v2" "secgroup" {
  name = var.name
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
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

resource "openstack_networking_secgroup_rule_v2" "dns" {
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 53
  port_range_max    = 53
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "dns-alt" {
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 5353
  port_range_max    = 5353
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}
