resource "openstack_compute_keypair_v2" "admins" {
  name       = "admins"
  public_key = file("${path.module}/authorized_keys")
}
