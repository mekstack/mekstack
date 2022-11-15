resource "openstack_dns_zone_v2" "zone" {
  name        = "docs.miem."
  email       = "19106@miem.hse.ru"
  description = "${local.project} zone"
  ttl         = 6000
  type        = "PRIMARY"
}

resource "openstack_dns_recordset_v2" "vip" {
  zone_id     = openstack_dns_zone_v2.zone.id
  name        = "docs.miem."
  description = "Docs VIP"
  ttl         = 3000
  type        = "A"
  records     = [openstack_networking_floatingip_v2.fip.address]
}
