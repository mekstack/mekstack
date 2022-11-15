resource "openstack_networking_network_v2" "network" {
  name                  = "${local.project} network"
  admin_state_up        = true
  port_security_enabled = true
}

resource "openstack_networking_subnet_v2" "subnet" {
  name       = "${local.project} subnet"
  network_id = openstack_networking_network_v2.network.id
  cidr       = "10.69.69.0/24"
  ip_version = 4
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}

resource "openstack_networking_router_v2" "router" {
  name                = "${local.project} router"
  external_network_id = data.openstack_networking_network_v2.public.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}
