resource "random_pet" "lb_target_group_http_name" {}

module "this_lb_http_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 3.0"

  name   = format("%s-%s", var.name, var.stage)
  vpc_id = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = var.tags
}

resource "aws_lb" "this" {
  name = format("%s-%s", var.name, var.stage)

  internal           = false
  load_balancer_type = "application"

  subnets         = var.public_subnet_ids
  security_groups = [module.this_lb_http_sg.this_security_group_id]

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "http_ip" {
  name = format("%s-http-ip", random_pet.lb_target_group_http_name.id)

  vpc_id      = var.vpc_id
  port        = var.ecs_container_port
  target_type = "ip"
  protocol    = "HTTP"

  health_check {
    enabled             = var.lb_health_check_enabled
    interval            = var.lb_health_check_interval
    path                = var.lb_health_check_path
    protocol            = "HTTP"
    timeout             = var.lb_health_check_timeout
    healthy_threshold   = var.lb_health_check_healthy_threshold
    unhealthy_threshold = var.lb_health_check_unhealthy_threshold
    matcher             = var.lb_health_check_matcher
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_lb.this]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.http_ip.arn
    type             = "forward"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "https" {
  count = var.lb_certificate_arn == "" ? 0 : 1

  load_balancer_arn = aws_lb.this.arn

  port     = 443
  protocol = "HTTPS"

  ssl_policy      = var.lb_ssl_policy
  certificate_arn = var.lb_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.http_ip.arn
    type             = "forward"
  }

  lifecycle {
    create_before_destroy = true
  }
}
