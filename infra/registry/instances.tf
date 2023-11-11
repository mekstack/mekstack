
resource "openstack_compute_servergroup_v2" "servergroup" {
  name     = "servergroup"
  policies = ["anti-affinity"]
}


resource "openstack_compute_instance_v2" "instance" {
  count = var.instances

  name            = "docker-registry0${count.index + 1}"
  image_id        = var.image_id
  flavor_name     = "m2s.small"
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


