module "network" {
  source               = "./modules/network"
  vpc10_cidr             = module.vars.vpc10_cidr
  vpc20_cidr             = module.vars.vpc20_cidr
  sn_vpc10_pub           = module.vars.sn_vpc10_pub
  sn_vpc10_pub2           = module.vars.sn_vpc10_pub2
  sn_vpc20_priv           = module.vars.sn_vpc20_priv
}

module "compute" {
  source                   = "./modules/compute"
  vpc10_id = module.network.vpc10_id
  vpc20_id = module.network.vpc20_id
  sn_vpc10_pub = module.network.sn_vpc10_pub_id
  sn_vpc10_pub2 = module.network.sn_vpc10_pub2
  sn_vpc20_priv = module.network.sn_vpc20_priv
  vpc10_cidr = module.network.vpc10_id
  vpc20_cidr = module.network.vpc20_id
}