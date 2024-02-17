locals {
  images = [
    {
      name        = "Ubuntu 22.04.3 LTS"
      url         = "https://cloud-images.ubuntu.com/daily/server/jammy/current/jammy-server-cloudimg-amd64.img"
      min_disk_gb = 3
      min_ram_mb  = 512
      decompress  = false
      visibility  = "private"
      properties = {
        os_type = "linux"
      }
    },
    {
      name        = "Fedora CoreOS 38"
      url         = "https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/38.20230806.3.0/x86_64/fedora-coreos-38.20230806.3.0-openstack.x86_64.qcow2.xz"
      min_disk_gb = 3
      min_ram_mb  = 512
      decompress  = true
      visibility  = "public"
      properties = {
        os_type   = "linux"
        os_distro = "fedora-coreos"
      }
    }
  ]
}

resource "openstack_images_image_v2" "image" {
  for_each = { for img in local.images : img.name => img }

  name             = each.value.name
  image_source_url = each.value.url
  decompress       = each.value.decompress
  image_cache_path = "./image_cache"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = each.value.visibility
  min_disk_gb      = each.value.min_disk_gb
  min_ram_mb       = each.value.min_ram_mb
  properties       = each.value.properties
}
