resource "openstack_identity_project_v3" "mekstack" {
  name        = "Mekstack"
  description = "Service project for custom images & other utils"
}

resource "openstack_identity_user_v3" "imagebuilder" {
  name               = "imagebuilder"
  default_project_id = openstack_identity_project_v3.mekstack.id
}

data "openstack_identity_role_v3" "member" {
  name = "member"
}

resource "openstack_identity_role_assignment_v3" "role_assignment_1" {
  user_id    = openstack_identity_user_v3.imagebuilder.id
  project_id = openstack_identity_project_v3.mekstack.id
  role_id    = data.openstack_identity_role_v3.member.id
}
