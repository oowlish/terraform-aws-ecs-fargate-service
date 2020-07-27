data "aws_ecs_cluster" "this" {
  cluster_name = var.ecs_cluster_name
}

module "this_ecs_http_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.13.0"

  name   = format("%s-service-http", var.name)
  vpc_id = var.vpc_id

  egress_rules = ["all-all"]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.this_lb_http_sg.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  tags = var.tags
}

resource "aws_ecs_service" "this" {
  name = format("%s-%s", var.name, var.stage)

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
    security_groups  = [module.this_ecs_http_sg.this_security_group_id]
    subnets          = var.ecs_assign_public_ip ? var.public_subnet_ids : var.private_subnet_ids
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}
