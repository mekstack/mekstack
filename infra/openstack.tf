terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.52.1"
    }
  }
}

provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
}
