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

variable "name" {
  type = string
}

variable "key_pair" {
  type = string
}

variable "image_name" {
  type = string
}

variable "public_network" {
  type = string
}
