module "k3s" {
  source = "/home/ubuntu/mekstack/k3s-openstack-tf-module/"

  name                = "k3s-prod"
  key_pair            = "admins"
  master_node_count   = 3
  image_id            = "95902ff0-3c07-4060-8083-8c489753c322"
  public_network_name = "public"
  flavor_name         = "m2s.large"
  kubeapi_lb          = true
  add_dns_record      = true
  kubeapi_lb_dns_fqdn = "kube3.local."
}

terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
}
