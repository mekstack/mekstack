terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.52.1"
    }
  }
}


variable "instance_count" {
  type    = number
  default = 2
}
variable "image" {
  type = string
  default = "Mekstack Ubuntu 22.04.3 LTS"
}

variable "flavor" {
  type = string
  default = "m2s.small"
}

variable "network" {
  type = string
  default = "registry_network_1"
}

variable "subnet" {
  type = string
  default = "registry_subnet_1"
}

variable "router" {
  type = string
  default = "registry_router_1"
}
