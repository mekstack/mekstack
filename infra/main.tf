module "admin" {
  source = "./admin"
}

module "sneedaas" {
  source = "./sneedaas"

  name           = "SNEEDaaS"
  key_pair       = "admins"
  image_id       = module.admin.image["Ubuntu 22.04.3 LTS"].id
  public_network = module.admin.public_network
}

module "dnosha" {
  source = "./dnosha"

  name           = "DNoS-HA"
  key_pair       = "admins"
  image_id       = module.admin.image["Ubuntu 22.04.3 LTS"].id
  public_network = module.admin.public_network
}

module "k3s" {
  source = "/home/ubuntu/mekstack/k3s-openstack-tf-module/"

  name                = "k3s-prod"
  key_pair            = "admins"
  master_node_count   = 3
  image_id            = module.admin.image["Ubuntu 22.04.3 LTS"].id
  public_network_name = module.admin.public_network.name
  flavor_name         = "m2s.large"
  kubeapi_lb          = true
  add_dns_record      = true
  kubeapi_lb_dns_fqdn = "kube3.local."

  depends_on = [module.admin, module.sneedaas, module.dnosha]
}
