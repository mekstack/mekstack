resource "openstack_lb_loadbalancer_v2" "lb" {
  name                  = var.name
  vip_subnet_id         = openstack_networking_subnet_v2.subnet.id
  loadbalancer_provider = "ovn"

  depends_on = [openstack_compute_instance_v2.instance]
}

resource "openstack_networking_floatingip_v2" "fip" {
  pool        = var.public_network
  address     = "172.18.218.180"
  description = "test registry"
}

resource "openstack_networking_floatingip_associate_v2" "lb_fip" {
  port_id     = openstack_lb_loadbalancer_v2.lb.vip_port_id
  floating_ip = openstack_networking_floatingip_v2.fip.address
}


// ======================== HTTP(S) Loadbalancer =======================

locals {
  protocol_ports = {
    "HTTP" : 80,
    "HTTPS" : 443
  }
}

resource "openstack_lb_listener_v2" "lb" {
  for_each = local.protocol_ports

  name            = each.key
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "TCP"
  protocol_port   = each.value
}

resource "openstack_lb_pool_v2" "lb" {
  for_each = local.protocol_ports

  name        = each.key
  listener_id = openstack_lb_listener_v2.lb[each.key].id
  protocol    = "TCP"
  lb_method   = "SOURCE_IP_PORT"
}

resource "openstack_lb_monitor_v2" "lb" {
  for_each = local.protocol_ports

  name        = "${each.key} ${each.value}"
  pool_id     = openstack_lb_pool_v2.lb[each.key].id
  type        = "TCP"
  delay       = 2
  timeout     = 1
  max_retries = 2
}

resource "openstack_lb_members_v2" "lb" {
  for_each = local.protocol_ports

  pool_id = openstack_lb_pool_v2.lb[each.key].id

  dynamic "member" {
    for_each = openstack_compute_instance_v2.instance[*].network[0].fixed_ip_v4

    content {
      address       = member.value
      protocol_port = each.value
    }
  }
}
