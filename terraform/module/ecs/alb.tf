resource "aws_alb" "public_alb" {
  count           = var.public == true ? 1 : 0
  name            = "${var.name-ecs}-public-alb"
  security_groups = [aws_security_group.this.id]
  subnets         = var.subnets_public

  tags = var.tags
}



resource "aws_alb" "internal_alb" {
  count           = var.internal == true ? 1 : 0
  name            = "${var.name-ecs}-internal-alb"
  security_groups = [aws_security_group.this.id]
  subnets         = var.subnets_private
  internal        = var.internal

  tags = var.tags
}

resource "aws_lb_listener" "http_public" {
  count             = var.public == true && var.enable_listener_https == false ? 1 : 0
  load_balancer_arn = aws_alb.public_alb[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "NOT FOUND"
      status_code  = "404"
    }
  }

  tags = {
    recriated    = "true"
    map-migrated = "d-server-00lpu89rymdv9m"
  }
}

resource "aws_lb_listener" "http_private" {
  count             = var.internal == true && var.enable_listener_https == false ? 1 : 0
  load_balancer_arn = aws_alb.internal_alb[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "NOT FOUND"
      status_code  = "404"
    }
  }

  tags = {
    recriated    = "true"
    map-migrated = "d-server-00lpu89rymdv9m"
  }
}


resource "aws_lb_listener" "https_public" {
  count             = var.public == true && var.enable_listener_https == true ? 1 : 0
  load_balancer_arn = aws_alb.public_alb[0].arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "NOT FOUND"
      status_code  = "404"
    }
  }
}


resource "aws_lb_listener" "https_private" {
  count             = var.internal == true && var.enable_listener_https == true ? 1 : 0
  load_balancer_arn = aws_alb.internal_alb[0].arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "NOT FOUND"
      status_code  = "404"
    }
  }
}