
resource "openstack_compute_servergroup_v2" "servergroup" {
  name     = "servergroup"
  policies = ["anti-affinity"]
}

resource "openstack_compute_keypair_v2" "my-cloud-key" {
  name       = "my-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIhZECaYYf3DmbgyHQJWyJqTIqzQSbF87JUTX5eL/mRm"
}

resource "openstack_compute_instance_v2" "instance" {
  count = var.instance_count

  name            = "instance-${count.index + 1}"
  image_name      = "Mekstack Ubuntu 22.04.3 LTS"
  flavor_name     = "m2s.small"
  key_pair        = "${openstack_compute_keypair_v2.my-cloud-key.name}"
  security_groups = ["default"]

  network {
    uuid = openstack_networking_network_v2.network[count.index].id
  }

  scheduler_hints {
    group = openstack_compute_servergroup_v2.servergroup.id
  }

  depends_on = [openstack_networking_subnet_v2.subnet]
}


