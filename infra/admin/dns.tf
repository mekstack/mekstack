resource "openstack_dns_zone_v2" "mekstack_zone" {
  name        = "mekstack.ru."
  email       = "19106@miem.hse.ru"
  description = "Mekstack project zone"
  ttl         = 3000
  type        = "PRIMARY"
}

resource "openstack_dns_recordset_v2" "horiozn" {
  zone_id     = openstack_dns_zone_v2.mekstack_zone.id
  name        = "mekstack.ru."
  description = "Mekstack horizon web dashboard address"
  ttl         = 3000
  type        = "A"
  records     = ["172.18.219.1"]
}

resource "openstack_dns_recordset_v2" "services" {
  zone_id     = openstack_dns_zone_v2.mekstack_zone.id
  name        = "*.mekstack.ru."
  ttl         = 3000
  type        = "A"
  records     = ["172.18.219.137"]
}

resource "openstack_dns_recordset_v2" "api" {
  zone_id     = openstack_dns_zone_v2.mekstack_zone.id
  name        = "*.api.mekstack.ru."
  description = "Mekstack service endpoints address"
  ttl         = 3000
  type        = "A"
  records     = ["172.18.219.1"]
}

resource "openstack_dns_zone_v2" "instances_zone" {
  name        = "int.mekstack.ru."
  email       = "19106@miem.hse.ru"
  description = "Mekstack instances zone"
  ttl         = 3000
  type        = "PRIMARY"
}

