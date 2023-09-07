resource "openstack_lb_loadbalancer_v2" "lb" {
  name                  = var.name
  vip_subnet_id         = openstack_networking_subnet_v2.subnet.id
  loadbalancer_provider = "ovn"

  depends_on = [openstack_compute_instance_v2.instance]
}

resource "openstack_networking_floatingip_v2" "fip" {
  pool        = data.openstack_networking_network_v2.public.name
  address     = "172.18.218.100"
  description = "${var.name} VIP"
}

resource "openstack_networking_floatingip_associate_v2" "lb_fip" {
  port_id     = openstack_lb_loadbalancer_v2.lb.vip_port_id
  floating_ip = openstack_networking_floatingip_v2.fip.address
}

// ======================== HTTP(S) Loadbalancer =======================

resource "openstack_lb_listener_v2" "lb" {
  name            = var.name
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "UDP"
  protocol_port   = 53
}

resource "openstack_lb_pool_v2" "lb" {
  name        = var.name
  listener_id = openstack_lb_listener_v2.lb.id
  protocol    = "UDP"
  lb_method   = "SOURCE_IP_PORT"
}

resource "openstack_lb_monitor_v2" "lb" {
  name        = var.name
  pool_id     = openstack_lb_pool_v2.lb.id
  type        = "UDP-CONNECT"
  delay       = 3
  timeout     = 1
  max_retries = 1
}

resource "openstack_lb_members_v2" "lb" {
  pool_id = openstack_lb_pool_v2.lb.id

  dynamic "member" {
    for_each = openstack_compute_instance_v2.instance[*].network[0].fixed_ip_v4

    content {
      address       = member.value
      protocol_port = 5353 # nonstandart port because 53 conflicts with systemd-resolved server
    }
  }
}
