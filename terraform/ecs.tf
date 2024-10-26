 module "ecs" {
   source                = "./module/ecs"
   name-ecs              = "demo-prod"
   vpc_id                = module.network.vpc_id
   subnets               = module.network.public_subnet_1a
   certificate_arn       = data.aws_acm_certificate.this.arn
 }

 