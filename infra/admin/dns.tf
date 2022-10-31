data "openstack_dns_zone_v2" "mekstack_zone" {
  name = "mekstack.ru."
}

resource "openstack_dns_recordset_v2" "mekstack_a_record" {
  zone_id     = data.openstack_dns_zone_v2.mekstack_zone.id
  name        = "mekstack.ru."
  description = "mekstack external address"
  ttl         = 3000
  type        = "A"
  records     = ["172.18.221.200"]
}

resource "openstack_dns_zone_v2" "status_zone" {
  name        = "status.mekstack.ru."
  email       = "19106@miem.hse.ru"
  description = "grafana zone"
  ttl         = 6000
  type        = "PRIMARY"
}

resource "openstack_dns_recordset_v2" "grafana_a_record" {
  zone_id     = openstack_dns_zone_v2.status_zone.id
  name        = "status.mekstack.ru."
  description = "grafana address"
  ttl         = 3000
  type        = "A"
  records     = ["172.18.221.200"]
}
