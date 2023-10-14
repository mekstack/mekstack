terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.52.1"
    }
  }
}

variable "image" {
  type = string
}

variable "public_network" {
  type = any
}
