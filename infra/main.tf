module "admin" {
  source = "./admin"
}

module "sneedaas" {
  source = "./sneedaas"

  name = "SNEEDaaS"
  key_pair = "admins"
  image_id = module.admin.image["jammy"].id
}

module "dnosha" {
  source = "./dnosha"

  name = "DNoS-HA"
  key_pair = "admins"
  image_id = module.admin.image["jammy"].id
}
