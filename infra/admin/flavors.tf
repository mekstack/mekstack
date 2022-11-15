locals {
  flavors = [
    {
      name  = "micro"
      vcpus = 2
      ram   = 512
      swap  = 512
      disk  = 5
    },
    {
      name  = "small"
      vcpus = 4
      ram   = 1024
      swap  = 1024
      disk  = 10
    },
    {
      name  = "medium"
      vcpus = 6
      ram   = 2048
      swap  = 2048
      disk  = 15
    },
    {
      name  = "large"
      vcpus = 8
      ram   = 4096
      swap  = 2048
      disk  = 20
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
