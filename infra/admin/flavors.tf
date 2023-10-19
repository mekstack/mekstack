locals {
  flavors = [
    {
      name  = "micro"
      vcpus = 4
      ram   = 512
      swap  = 512
      disk  = 10
    },
    {
      name  = "small"
      vcpus = 6
      ram   = 1024
      swap  = 1024
      disk  = 15
    },
    {
      name  = "medium"
      vcpus = 8
      ram   = 2048
      swap  = 2048
      disk  = 20
    },
    {
      name  = "large"
      vcpus = 10
      ram   = 4096
      swap  = 2048
      disk  = 25
    },
    {
      name  = "xxl"
      vcpus = 12
      ram   = 5120
      swap  = 2048
      disk  = 30
    }
  ]
}

resource "openstack_compute_flavor_v2" "m2s" {
  for_each = { for id, flavor in local.flavors : id => flavor }

  name      = "m2s.${each.value.name}"
  vcpus     = each.value.vcpus
  ram       = each.value.ram
  swap      = each.value.swap
  disk      = each.value.disk
  is_public = true
  flavor_id = each.key

  extra_specs = {
    "hw:numa_nodes" = 1,
    "hw:cpu_policy" = "shared"
  }
}
