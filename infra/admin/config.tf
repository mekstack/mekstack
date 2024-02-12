terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    region = "ru-central1"
    key    = "admin.tfstate"
    bucket = "mekstack-tfstate"

    # Those are required because terraform validates against aws
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

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
