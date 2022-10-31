resource "openstack_lb_loadbalancer_v2" "lb" {
  name           = "Docs lb"
  vip_network_id = "14bfae93-4645-4db5-81a3-d62e8c71f22f"
  vip_subnet_id  = "44e1bc88-ca00-4943-99e4-1328740fe2ab"
}

resource "openstack_lb_listener_v2" "listener" {
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb.id
  protocol        = "HTTP"
  protocol_port   = 80
}

resource "openstack_lb_pool_v2" "pool" {
  listener_id = openstack_lb_listener_v2.listener.id
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
}

resource "openstack_lb_members_v2" "members" {
  pool_id = openstack_lb_pool_v2.pool.id

  member {
    address       = openstack_networking_floatingip_v2.web-1.address
    protocol_port = 80
  }

  member {
    address       = openstack_networking_floatingip_v2.web-2.address
    protocol_port = 80
  }
}

resource "openstack_lb_monitor_v2" "monitor" {
  pool_id        = openstack_lb_pool_v2.pool.id
  url_path       = "/health"
  type           = "HTTP"
  expected_codes = 200
  delay          = 10
  timeout        = 10
  max_retries    = 3
}
