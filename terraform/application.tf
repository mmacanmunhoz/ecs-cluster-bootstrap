  locals {
    scale_actions = {
      "scale_in" = {
        schedule     = "cron(00 06 * * ? *)"
        min_capacity = 1
        max_capacity = 5
      }
      "scale_out" = {
        schedule     = "cron(00 11 * * ? *)"
        min_capacity = 10
        max_capacity = 20
      }
    }
  }


module "demo" {
  source = "./module/ecs-application"  

  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.private_subnet_1a
  tags              = local.tags
  app_env           = local.environment
  app_hostname      = local.dns_name
  route53_id        = data.aws_route53_zone.selected.id
  enable_cloudfront = false

  application = {
    app_name                  = local.app_name module.
    listener_arn              = module.ecs.public_lb_listener
    ecs_cluster_id            = module.ecs.ecs_cluster_id
    ecs_cluster_name          = module.ecs.ecs_cluster_name
    ecs_container_definitions = file("${path.module}/task/demo_task_definition.json")
    health_check              = "/"
    ecs_execution_role_name   = aws_iam_role.this.name
    ecs_execution_role_arn    = aws_iam_role.this.arn
    lb_dns                    = module.ecs.private_lb_dns
  }
}


resource "aws_iam_role" "this" {
  name = "${local.app_name}-task-execution-role"
  path = "/"

  assume_role_policy = data.aws_iam_policy_document.ecs-assume-role.json
}

  resource "aws_appautoscaling_scheduled_action" "this" {
    for_each           = local.scale_actions
    name               = "ecs_demo_${each.key}"
    service_namespace  = module.demo.app-service-namespace
    resource_id        = module.demo.app-resource-id
    scalable_dimension = module.demo.app-scalable-dimension
    schedule           = each.value.schedule
    timezone           = "America/Sao_Paulo"

    scalable_target_action {
      min_capacity = each.value.min_capacity
      max_capacity = each.value.max_capacity
    }
    depends_on = [ module.demo ]
  }