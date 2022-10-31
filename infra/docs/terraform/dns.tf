resource "openstack_dns_zone_v2" "docs_zone" {
  name        = "docs.corp."
  email       = "19106@miem.hse.ru"
  description = "docs zone"
  ttl         = 6000
  type        = "PRIMARY"
}

resource "openstack_dns_recordset_v2" "vip" {
  zone_id     = openstack_dns_zone_v2.docs_zone.id
  name        = "docs.corp."
  description = "Docs web frontend"
  ttl         = 3000
  type        = "A"
  records     = [openstack_lb_loadbalancer_v2.lb.vip_address]
}

resource "openstack_dns_recordset_v2" "web-1" {
  zone_id     = openstack_dns_zone_v2.docs_zone.id
  name        = "web-1.docs.corp."
  description = "web-1 instance"
  ttl         = 3000
  type        = "A"
  records     = [openstack_networking_floatingip_v2.web-1.address]
}

resource "openstack_dns_recordset_v2" "web-2" {
  zone_id     = openstack_dns_zone_v2.docs_zone.id
  name        = "web-2.docs.corp."
  description = "web-2 instance"
  ttl         = 3000
  type        = "A"
  records     = [openstack_networking_floatingip_v2.web-2.address]
}
