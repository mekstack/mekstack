
resource "openstack_compute_servergroup_v2" "servergroup" {
  name     = "servergroup"
  policies = ["anti-affinity"]
}

resource "openstack_compute_instance_v2" "instance" {
  count = var.instance_count

  name            = "docker-registry_${count.index + 1}"
  image_name      = var.image
  flavor_name     = var.flavor
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


