resource "openstack_networking_network_v2" "network" {
  name           = "network_1"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet" {
  name        = "subnet_1"
  network_id  = openstack_networking_network_v2.network.id
  cidr        = "172.16.98.0/23"
  ip_version  = 4
}

resource "openstack_networking_router_v2" "router" {
  name            = "router_"
  admin_state_up  = true
  external_network_id = "4d942526-390d-40a1-8bd3-934405fd4281"
}

resource "openstack_networking_router_interface_v2" "router_interface" {

  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

resource "openstack_networking_router_route_v2" "router_route" {

  router_id        = openstack_networking_router_v2.router.id
  destination_cidr = "172.18.217.0/24"
  next_hop         = "172.18.218.2"
}


resource "openstack_networking_floatingip_v2" "fip" {
  count = var.instance_count
  pool = "public"
}

resource "openstack_compute_floatingip_associate_v2" "fip" {
  count = var.instance_count
  
  floating_ip = element(openstack_networking_floatingip_v2.fip[*].address, count.index)
  instance_id = openstack_compute_instance_v2.instance[count.index].id
}
