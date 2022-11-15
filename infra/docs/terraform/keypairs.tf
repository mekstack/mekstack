locals {
  deploy_host_pubkey = try(
    file("~/.ssh/id_ed25519.pub"),
    file("~/.ssh/id_rsa.pub")
  )
  drone_pubkey   = file("${path.module}/../deploy_key")
  admins_pubkeys = file("${path.module}/../../authorized_keys")

  all_pubkeys = join("\n", [local.admins_pubkeys, local.drone_pubkey, local.deploy_host_pubkey])
}

resource "openstack_compute_keypair_v2" "all" {
  name       = "all"
  public_key = local.all_pubkeys
}
