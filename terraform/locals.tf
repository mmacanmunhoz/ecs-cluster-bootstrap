locals {
  app_name    = "demo"
  environment = "prod"
  region = "us-east-1"
  dns_name    = "${local.app_name}.demopoc.com.br"
  domain_names = [local.dns_name]
  tags = {
    managed_by = "terraform"
    environment = terraform.workspace
  }
}