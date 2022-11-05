resource "openstack_identity_project_v3" "drone" {
  name        = "drone"
  description = "Project for Drone CI/CD"
}

resource "openstack_identity_project_v3" "docs" {
  name        = "docs"
  description = "Project for docs.mekstack.ru"
}

resource "openstack_identity_project_v3" "mekstack" {
  name        = "mekstack"
  description = "Project for mekstack images"
}

