resource "random_integer" "priority" {
  min = 1
  max = 50000
  keepers = {
    listener_arn = local.application.listener_arn
  }
}

resource "aws_lb_target_group" "this" {
  name        = "${local.application.app_name}-tg"
  port        = local.application.lb_target_group_port
  protocol    = local.application.listener_rule_protocol
  target_type = local.application.listener_rule_target_type
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = "5"
    port                = "traffic-port"
    path                = local.application.health_check
    protocol            = local.application.listener_rule_protocol
    interval            = 30
    matcher             = "200"
  }

  tags = var.tags
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = random_integer.priority.keepers.listener_arn
  priority     = random_integer.priority.result

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    host_header {
      values = ["%{if var.external_domain == false}${var.app_hostname}%{else}${var.external_domain_url}%{endif}"]
    }
  }

  tags = var.tags
}
