terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.52.1"
    }
  }
}

data "openstack_identity_auth_scope_v3" "current" {
  name = "current"
}

