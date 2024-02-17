data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

resource "openstack_compute_servergroup_v2" "servergroup" {
  name     = var.name
  policies = ["anti-affinity"]
}

resource "openstack_compute_instance_v2" "instance" {
 count = 2

  name            = "${var.name}-${count.index + 1}"
  image_id        = data.openstack_images_image_v2.image.id
  flavor_name     = "m2s.medium"
  key_pair        = var.key_pair
  security_groups = ["default"]

  network {
    uuid = openstack_networking_network_v2.network.id
  }

  scheduler_hints {
    group = openstack_compute_servergroup_v2.servergroup.id
  }

  depends_on = [openstack_networking_subnet_v2.subnet]
}
