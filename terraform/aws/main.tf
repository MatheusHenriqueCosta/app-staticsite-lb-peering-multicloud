module "network" {
  source               = "./modules/network"
  vpc10_cidr             = var.vpc10_cidr.id
  vpc20_cidr             = var.vpc20_cidr.id
  sn_vpc10_pub           = var.sn_vpc10_pub.id
  sn_vpc10_pub2           = var.sn_vpc10_pub2.id
  sn_vpc20_priv           = var.sn_vpc20_priv.id
}

module "compute" {
  source                   = "modules/compute"
  vpc10_id                 = module.network.vpc10_id
  vpc20_id                 = module.network.vpc20_id
  sn_vpc10_pub_id          = module.network.sn_vpc10_pub_id
  sn_vpc10_pub2            = module.network.sn_vpc10_pub2
}