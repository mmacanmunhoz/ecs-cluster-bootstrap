locals {
  application = {
    create_repo                         = try(var.application.create_repo, true)
    app_name                            = try(var.application.app_name, "")
    listener_arn                        = try(var.application.listener_arn, "")
    ecs_cluster_id                      = try(var.application.ecs_cluster_id, "")
    ecs_cluster_name                    = try(var.application.ecs_cluster_name, "")
    ecs_container_definitions           = try(var.application.ecs_container_definitions, "")
    listener_rule_protocol              = try(var.application.listener_rule_protocol, "HTTP")
    listener_rule_target_type           = try(var.application.listener_rule_target_type, "ip")
    ecs_min_capacity                    = try(var.application.ecs_min_capacity, "1")
    health_check                        = try(var.application.health_check, "/health")
    lb_target_group_port                = try(var.application.lb_target_group_port, 80)
    lb_container_port                   = try(var.application.lb_container_port, 80)
    lb_dns                              = try(var.application.lb_dns, "")
    ecs_execution_role_arn              = try(var.application.ecs_execution_role_arn, null)
    ecs_execution_role_name             = try(var.application.ecs_execution_role_name, null)
    deployment_maximum_percent          = try(var.application.deployment_maximum_percent, 200)
    deployment_minimum_healthy_percent  = try(var.application.deployment_minimum_healthy_percent, 100)
    deployment_circuit_breaker          = try(var.application.deployment_circuit_breaker, true)
    deployment_circuit_breaker_rollback = try(var.application.deployment_circuit_breaker_rollback, true)
  }
}

