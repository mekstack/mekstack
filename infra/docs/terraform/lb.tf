resource "openstack_lb_loadbalancer_v2" "lb" {
  name                  = "${local.project} loadbalancer"
  vip_subnet_id         = openstack_networking_subnet_v2.subnet.id
  loadbalancer_provider = "ovn"
}

resource "openstack_networking_floatingip_v2" "fip" {
  pool = data.openstack_networking_network_v2.public.name
}

resource "openstack_networking_floatingip_associate_v2" "lb-fip" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  port_id     = openstack_lb_loadbalancer_v2.lb.vip_port_id
}

output "fip-address" {
  value = openstack_networking_floatingip_v2.fip.address
}

// ========================== Port Forwarding ===========================

resource "openstack_lb_listener_v2" "port-forward" {
  for_each = { for idx, query in local.port_forwards : idx => query }

  name            = each.value.name
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = each.value.protocol
  protocol_port   = each.value.dst_port
}

resource "openstack_lb_pool_v2" "port-forward" {
  for_each = { for idx, query in local.port_forwards : idx => query }

  name        = each.value.name
  listener_id = openstack_lb_listener_v2.port-forward[each.key].id
  protocol    = each.value.protocol
  lb_method   = "SOURCE_IP_PORT"
}

resource "openstack_lb_member_v2" "port-forward" {
  for_each = { for idx, query in local.port_forwards : idx => query }

  name          = each.value.name
  pool_id       = openstack_lb_pool_v2.port-forward[each.key].id
  address       = each.value.to_address
  protocol_port = each.value.to_port
}

// ======================== HTTP(S) Loadbalancer =======================

resource "openstack_lb_listener_v2" "web" {
  name            = "${local.project} HTTP"
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "TCP"
  protocol_port   = 80
}

resource "openstack_lb_pool_v2" "web" {
  name        = "${local.project} HTTP"
  listener_id = openstack_lb_listener_v2.web.id
  protocol    = "TCP"
  lb_method   = "SOURCE_IP_PORT"
}

resource "openstack_lb_monitor_v2" "web" {
  name        = "${local.project} TCP 80"
  pool_id     = openstack_lb_pool_v2.web.id
  type        = "TCP"
  delay       = 20
  timeout     = 10
  max_retries = 5
}

resource "openstack_lb_members_v2" "web" {
  pool_id = openstack_lb_pool_v2.web.id

  dynamic "member" {
    for_each = toset(local.instances)

    content {
      address       = openstack_compute_instance_v2.instance[member.value].network[0].fixed_ip_v4
      protocol_port = 80
    }
  }
}

