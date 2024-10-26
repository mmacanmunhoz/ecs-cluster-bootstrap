module "container_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 5.2.0"

  name        = "${local.application.app_name}-container_sg"
  description = "Security group for container with HTTP ports open within VPC"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = merge(
    var.tags,
    {
      Terraform = "true"
    },
  )
}