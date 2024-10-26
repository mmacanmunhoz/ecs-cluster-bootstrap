module "log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 5.6.1"

  name              = "/ecs/${local.application.app_name}-logs"
  retention_in_days = 120
}
