provider "local" {}

resource "local_file" "hosts" {
  filename = "${path.module}/docker-registry/hosts"

  content = <<-EOF
    [servers]
    registry-1 ansible_host=${openstack_networking_floatingip_v2.fip.address} ansible_port=2201
    registry-2 ansible_host=${openstack_networking_floatingip_v2.fip.address} ansible_port=2202
  EOF
  file_permission = "0664"
}


resource "local_file" "ansible_cfg" {
  filename = "${path.module}/docker-registry/ansible.cfg"

  content = <<-EOF
    [defaults]
    host_key_cheking = false
    inventory = ./hosts
  EOF
  file_permission = "0664"
}

