locals {
  key_files_contents = format("%s  %s", file("${path.module}/../../authorized_keys"), file("${path.module}/../deploy_key"))
} 

resource "openstack_compute_keypair_v2" "admin-deploy" {
  name       = "admin-deploy"
  public_key = local.key_files_contents
}
