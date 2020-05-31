resource "aws_lb" "this" {
  name = local.name_preffix

  internal           = false
  load_balancer_type = "application"

  subnets         = var.public_subnet_ids
  security_groups = var.lb_security_group_ids

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "http" {
  name = "${local.name_prefix}-http-tg"

  vpc_id      = var.vpc_id
  port        = var.ecs_service_container_port
  target_type = "ip"
  protocol    = "HTTP"


  health_check {
    enabled             = var.target_group_health_check_enabled
    interval            = var.target_group_health_check_interval
    path                = var.target_group_health_check_path
    protocol            = "HTTP"
    timeout             = var.target_group_health_check_timeout
    healthy_threshold   = var.target_group_health_check_healthy_threshold
    unhealthy_threshold = var.target_group_health_check_unhealthy_threshold
    matcher             = var.target_group_health_check_matcher
  }

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_alb.this]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.this.arn

  port     = aws_lb_target_group.http.port
  protocol = aws_lb_target_group.http.protocol

  default_action {
    target_group_arn = aws_alb_target_group.http.arn
    type             = "forward"
  }

  lifecycle {
    create_before_destroy = true
  }
}
