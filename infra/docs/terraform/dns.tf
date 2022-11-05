resource "openstack_dns_zone_v2" "docs_zone" {
  name        = "docs.miem."
  email       = "19106@miem.hse.ru"
  description = "docs zone"
  ttl         = 6000
  type        = "PRIMARY"
}

resource "openstack_dns_recordset_v2" "web-1" {
  zone_id     = openstack_dns_zone_v2.docs_zone.id
  name        = "web-1.docs.miem."
  description = "web-1 instance"
  ttl         = 3000
  type        = "A"
  records     = [openstack_compute_instance_v2.web-1.access_ip_v4]
}

resource "openstack_dns_recordset_v2" "web-2" {
  zone_id     = openstack_dns_zone_v2.docs_zone.id
  name        = "web-2.docs.miem."
  description = "web-2 instance"
  ttl         = 3000
  type        = "A"
  records     = [openstack_compute_instance_v2.web-2.access_ip_v4]
}
