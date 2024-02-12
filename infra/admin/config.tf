terraform {

  }
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

data "openstack_identity_auth_scope_v3" "current" {
  name = "current"
}

provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
}
