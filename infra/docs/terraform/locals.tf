locals {
  project   = "Docs"
  instances = ["web1", "web2", "web3"]
  port_forwards = [
    for instance in local.instances :
    {
      name       = "SSH for ${instance}"
      protocol   = "TCP"
      dst_port   = index(local.instances, instance) + 2201
      to_port    = 22
      to_address = openstack_compute_instance_v2.instance[instance].network[0].fixed_ip_v4
    }
  ]
}
