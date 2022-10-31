resource "openstack_networking_network_v2" "miem" {
  name           = "miem"
  description    = "Network with access to MIEM networks"
  admin_state_up = true
  external       = true
  shared         = true

  segments {
    network_type     = "vlan"
    physical_network = "physnet1"
    segmentation_id  = "220"
  }
}

resource "openstack_networking_subnet_v2" "miem" {
  network_id  = openstack_networking_network_v2.miem.id
  name        = "miem-subnet"
  cidr        = "172.18.220.0/24"
  gateway_ip  = "172.18.220.1"
  enable_dhcp = true

  allocation_pool {
    start = "172.18.220.51"
    end   = "172.18.220.254"
  }
}
