data "openstack_dns_zone_v2" "mekstack_zone" {
  name = "mekstack.ru."
}

resource "openstack_dns_recordset_v2" "mekstack_a_record" {
  zone_id     = data.openstack_dns_zone_v2.mekstack_zone.id
  name        = "mekstack.ru."
  description = "Mekstack external address"
  ttl         = 3000
  type        = "A"
  records     = ["172.18.221.200"]
}
