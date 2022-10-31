resource "openstack_dns_zone_v2" "drone_zone" {
  name        = "drone.miem."
  email       = "19106@miem.hse.ru"
  description = "drone zone"
  ttl         = 6000
  type        = "PRIMARY"
}

resource "openstack_dns_recordset_v2" "drone_internal" {
  zone_id     = openstack_dns_zone_v2.drone_zone.id
  name        = "drone.miem."
  description = "Drone web frontend"
  ttl         = 3000
  type        = "A"
  records     = [openstack_networking_floatingip_v2.master-fip.address]
}

resource "openstack_dns_recordset_v2" "drone_master" {
  zone_id     = openstack_dns_zone_v2.drone_zone.id
  name        = "master.drone.miem."
  description = "Drone web frontend"
  ttl         = 3000
  type        = "A"
  records     = [openstack_compute_instance_v2.master.access_ip_v4]
}

resource "openstack_dns_recordset_v2" "drone_exec1_floating" {
  zone_id     = openstack_dns_zone_v2.drone_zone.id
  name        = "exec1.drone.miem."
  description = "Drone slave"
  ttl         = 3000
  type        = "A"
  records     = [openstack_networking_floatingip_v2.exec1-fip.address]
}
