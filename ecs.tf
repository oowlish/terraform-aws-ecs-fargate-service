data "aws_ecs_cluster" "this" {
  cluster_name = var.ecs_cluster_name
}

resource "random_string" "ecs_service_this_name" {
  length  = 8
  special = false
}

resource "aws_ecs_service" "this" {
  name = format("%s-%s-%s", var.name, var.stage, random_string.ecs_service_this_name.result)

  cluster = data.aws_ecs_cluster.this.arn

  task_definition = var.ecs_task_definition_arn
  desired_count   = var.ecs_desired_count

  platform_version = var.fargate_platform_version
  launch_type      = "FARGATE"
  propagate_tags   = "SERVICE"

  enable_ecs_managed_tags = true

  deployment_maximum_percent         = var.ecs_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.ecs_deployment_minimum_healthy_percent
  health_check_grace_period_seconds  = var.ecs_health_check_grace_period_seconds

  deployment_controller {
    type = var.ecs_deployment_controller_type
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.http_ip.arn
    container_name   = var.ecs_container_name
    container_port   = var.ecs_container_port
  }

  network_configuration {
    assign_public_ip = var.ecs_assign_public_ip
    security_groups  = var.ecs_security_group_ids
    subnets          = var.ecs_assign_public_ip ? var.public_subnet_ids : var.private_subnet_ids
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_count]
  }
}
