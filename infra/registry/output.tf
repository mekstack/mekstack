resource "null_resource" "write_hosts_file" {
  triggers = {
    ip_addresses = sha256(jsonencode(openstack_networking_floatingip_v2.fip[*].address))
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "${join("\n", openstack_networking_floatingip_v2.fip[*].address)}" > ./registry/docker-registry/hosts
      echo "[defaults]\ninventory = ./hosts\nremote_user = ubuntu\nhost_key_checking = false" > ./registry/docker-registry/ansible.cfg
    EOT
  }
}
