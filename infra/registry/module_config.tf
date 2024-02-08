terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.52.1"
    }
  }
}

variable "name" {
  type = string
}

variable "key_pair" {
  type = string
}

variable "image_id" {
  type = string
}

variable "public_network" {
  type = any
}
