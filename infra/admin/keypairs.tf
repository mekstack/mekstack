resource "openstack_compute_keypair_v2" "admins" {
  name       = "admins"
  public_key = file("${path.module}/authorized_keys")
}

resource "openstack_compute_keypair_v2" "kayobe" {
  name       = "kayobe"
  public_key = file("~/.ssh/id_ed25519.pub")
}
