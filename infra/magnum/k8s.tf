resource "openstack_containerinfra_clustertemplate_v1" "k8s" {
  name                  = "k8s"
  image                 = var.image
  flavor                = "m2s.large"
  master_flavor         = "m2s.large"
  dns_nameserver        = "172.18.218.200"
  server_type           = "vm"
  floating_ip_enabled   = false
  external_network_id   = var.public_network.id
  tls_disabled          = false
  public                = false
  cluster_distro        = "fedora-coreos"
  volume_driver         = "cinder"
  registry_enabled      = false
  docker_storage_driver = "overlay2"
  network_driver        = "calico"
  coe                   = "kubernetes"
  master_lb_enabled     = true
  hidden                = false

  labels = {
    kube_tag                       = "v1.26.8-rancher1"
    container_runtime              = "containerd"
    containerd_version             = "1.6.20"
    containerd_tarball_sha256      = "1d86b534c7bba51b78a7eeb1b67dd2ac6c0edeb01c034cc5f590d5ccd824b416"
    coredns_tag                    = "1.11.1"
    calico_tag                     = "v3.21.2"
    cloud_provider_tag             = "v1.26.3"
    autoscaler_tag                 = "v1.26.3"
    cinder_csi_plugin_tag          = "v1.26.3"
    k8s_keystone_auth_tag          = "v1.26.3"
    octavia_ingress_controller_tag = "v1.26.3"
    csi_snapshotter_tag            = "v6.2.1"
    csi_attacher_tag               = "v4.2.0"
    csi_resizer_tag                = "v1.7.0"
    csi_provisioner_tag            = "v3.4.1"
    csi_node_driver_registrar_tag  = "v2.8.0"
    prometheus_adapter_enabled     = "false"
    kube_dashboard_enabled         = "false"
    ingress_controller             = "octavia"
    cinder_csi_enabled             = "true"
    selinux_mode                   = "permissive"
    master_lb_floating_ip_enabled  = "true"
    kubecontroller_options         = "--secure-port=10257"
    kubelet_options                = "--allowed-unsafe-sysctls net.ipv4.ip_forward"
    octavia_provider               = "ovn"
    octavia_lb_algorithm           = "SOURCE_IP_PORT"
  }
}

resource "openstack_containerinfra_cluster_v1" "mekstack" {
  name                = "mekstack"
  cluster_template_id = openstack_containerinfra_clustertemplate_v1.k8s.id
  master_count        = 3
  node_count          = 3
  keypair             = "kayobe"
}
