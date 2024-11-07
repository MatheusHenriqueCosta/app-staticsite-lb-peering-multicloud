module "network" {
  source               = "modules/network"
}

module "compute" {
  source                   = "modules/compute"
  vpc10_id                 = module.network.vpc10_id
  vpc20_id                 = module.network.vpc20_id
  sn_vpc10_pub_id          = module.network.sn_vpc10_pub_id
  sn_vpc10_pub2            = module.network.sn_vpc10_pub2
}