resource "aws_ecs_service" "this" {
  name = local.name_prefix

  cluster = data.aws_ecs_cluster.this.arn

  task_definition = var.ecs_service_task_definition_arn
  desired_count   = var.ecs_service_desired_count

  launch_type    = "FARGATE"
  propagate_tags = "SERVICE"

  enable_ecs_managed_tags = true

  deployment_maximum_percent         = var.ecs_service_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.ecs_service_deployment_minimum_healthy_percent
  health_check_grace_period_seconds  = var.ecs_service_health_check_grace_period_seconds


  load_balancer {
    target_group_arn = aws_alb_target_group.http.arn
    container_name   = var.ecs_service_container_name
    container_port   = var.ecs_service_container_port
  }

  network_configuration {
    assign_public_ip = var.ecs_service_assign_public_ip
    security_groups  = var.ecs_service_security_group_ids
    subnets          = var.ecs_service_assign_public_ip ? var.public_subnet_ids : var.private_subnet_ids
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}
