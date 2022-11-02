data "openstack_networking_secgroup_v2" "default" {
  name = "default"
}

resource "openstack_networking_secgroup_rule_v2" "http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 80
  port_range_max    = 80
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
}

resource "openstack_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 443
  port_range_max    = 443
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
}

