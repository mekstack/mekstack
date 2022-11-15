resource "openstack_networking_network_v2" "public" {
  name           = "public"
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

resource "openstack_networking_subnet_v2" "public" {
  network_id      = openstack_networking_network_v2.public.id
  name            = "public-subnet"
  cidr            = "172.18.220.0/24"
  gateway_ip      = "172.18.220.1"
  enable_dhcp     = true
  dns_nameservers = ["172.18.221.21", "172.18.221.22", "172.18.221.23"]

  allocation_pool {
    start = "172.18.220.51"
    end   = "172.18.220.254"
  }
}
