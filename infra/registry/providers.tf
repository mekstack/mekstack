terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.52.1"
    }
  }
}



variable "instance_count" {
  type    = number
  default = 2
}