output "vm-name" {
  value = "${openstack_compute_instance_v2.instance[*].name}"
}
 
output "vm-id" {
  value = "${openstack_compute_instance_v2.instance[*].id}"
}
 
output "vm-ips" {
  value = "${openstack_compute_instance_v2.instance[*].network[0].fixed_ip_v4}"
}

output "subnt_1" {
  value = "${openstack_networking_subnet_v2.subnet[*].id}"
}

output "vm-floating-ip" {
  value = openstack_networking_floatingip_v2.fip[*].address
}

output "lb_loadbalancer_id" {
  value = openstack_lb_loadbalancer_v2.lb.id
}

