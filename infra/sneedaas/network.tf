data "openstack_networking_network_v2" "public" {
  name = var.public_network
}

resource "openstack_networking_network_v2" "network" {
  name           = var.name
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = var.name
  network_id = openstack_networking_network_v2.network.id
  cidr       = "10.0.0.0/24"
  ip_version = 4
}

resource "openstack_networking_router_v2" "router" {
  name                = var.name
  external_network_id = data.openstack_networking_network_v2.public.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

resource "openstack_networking_router_route_v2" "router_route" {
  depends_on = [openstack_networking_router_interface_v2.router_interface]

  router_id        = openstack_networking_router_v2.router.id
  destination_cidr = "172.18.217.0/24"
  next_hop         = "172.18.218.2"
}
