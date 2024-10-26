resource "aws_ecs_task_definition" "this" {
  family                   = local.application.app_name
  container_definitions    = local.application.ecs_container_definitions
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = local.application.ecs_execution_role_arn
  task_role_arn      = aws_iam_role.this.arn

  tags = var.tags
}

resource "aws_ecs_service" "this" {
  name    = local.application.app_name
  cluster = local.application.ecs_cluster_id

  task_definition                   = aws_ecs_task_definition.this.arn
  enable_ecs_managed_tags           = true
  enable_execute_command            = true
  platform_version                  = "LATEST"
  health_check_grace_period_seconds = 0
  desired_count                     = 0

  tags = var.tags

  deployment_maximum_percent         = local.application.deployment_maximum_percent
  deployment_minimum_healthy_percent = local.application.deployment_minimum_healthy_percent

  deployment_circuit_breaker {
    enable   = local.application.deployment_circuit_breaker 
    rollback = local.application.deployment_circuit_breaker_rollback
  }

  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 1
  }

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [module.container_sg.security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "${local.application.app_name}-task"
    container_port   = local.application.lb_container_port
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }
}

resource "aws_appautoscaling_target" "this" {
  max_capacity       = 100
  min_capacity       = local.application.ecs_min_capacity
  resource_id        = "service/${local.application.ecs_cluster_name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "this" {
  name               = "ecs_service_cpu_scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.resource_id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 50
    scale_in_cooldown  = 60
    scale_out_cooldown = 300
  }
}
