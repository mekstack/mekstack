resource "openstack_networking_network_v2" "public" {
  name        = "public"
  description = "Public Network"

  admin_state_up = true
  external       = true
  shared         = true

  segments {
    network_type     = "vlan"
    physical_network = "physnet1"
    segmentation_id  = "218"
  }
}

resource "openstack_networking_subnet_v2" "public" {
  name        = "public-subnet"
  description = "Public Subnet"

  network_id  = openstack_networking_network_v2.public.id
  cidr        = "172.18.218.0/23"
  gateway_ip  = "172.18.218.1"
  enable_dhcp = true

  dns_nameservers = ["172.18.218.200"]

  allocation_pool {
    start = "172.18.218.51"
    end   = "172.18.219.200"
  }
}

output "public_network" {
  value = openstack_networking_network_v2.public
}
