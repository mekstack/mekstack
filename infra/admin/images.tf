locals {
  images = [
    {
      name        = "jammy"
      url         = "https://cloud-images.ubuntu.com/daily/server/jammy/current/jammy-server-cloudimg-amd64.img"
      min_disk_gb = 3
      min_ram_mb  = 512
      properties = {
        os_type = "linux"
      }
    },
    {
      name        = "arch"
      url         = "https://geo.mirror.pkgbuild.com/images/latest/Arch-Linux-x86_64-cloudimg.qcow2"
      min_disk_gb = 3
      min_ram_mb  = 512
      properties = {
        os_type = "linux"
      }
    }
  ]
}

resource "openstack_images_image_v2" "image" {
  for_each = { for img in local.images : img.name => img }

  name             = each.value.name
  image_source_url = each.value.url
  image_cache_path = "./image_cache"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "public"
  min_disk_gb      = each.value.min_disk_gb
  min_ram_mb       = each.value.min_ram_mb
  properties       = each.value.properties
}

output "image" {
  value = {
    for img in local.images : img.name => {
      id = openstack_images_image_v2.image[img.name].id
    }
  }
}
