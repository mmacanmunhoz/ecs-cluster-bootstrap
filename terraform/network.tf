module "network" {
  source = "./modules/network"

  cluster_name = local.app_name
  region       = local.region
}
