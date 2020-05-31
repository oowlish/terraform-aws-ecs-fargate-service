resource "aws_appautoscaling_target" "this" {
  service_namespace  = "ecs"
  resource_id        = "service/${data.aws_ecs_cluster.this.cluster_name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  min_capacity = var.autoscaling_min_capacity
  max_capacity = var.autoscaling_max_capacity
}

resource "aws_appautoscaling_policy" "scale_up" {
  name = "${local.name_prefix}-scale-up"

  policy_type = "StepScaling"

  service_namespace  = aws_appautoscaling_target.this.service_namespace
  resource_id        = aws_appautoscaling_target.this.resource_id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.autoscaling_scale_up_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.autoscaling_scale_up_adjustment
    }
  }
}

resource "aws_appautoscaling_policy" "scale_down" {
  name = "${local.name_prefix}-scale-down"

  policy_type = "StepScaling"

  service_namespace  = aws_appautoscaling_target.this.service_namespace
  resource_id        = aws_appautoscaling_target.this.resource_id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.autoscaling_scale_down_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.autoscaling_scale_down_adjustment
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_service_high_cpu" {
  alarm_name = "${local.name_prefix}-high-cpu"

  namespace   = "ECS/ContainerInsights"
  metric_name = "CpuUtilized"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 3
  threshold           = var.autoscaling_high_cpu_threshold

  dimensions = {
    ClusterName = data.aws_ecs_cluster.this.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [aws_appautoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "ecs_service_low_cpu" {
  alarm_name = "${local.name_prefix}-low-cpu"

  namespace   = "ECS/ContainerInsights"
  metric_name = "CpuUtilized"

  comparison_operator = "LessThanOrEqualToThreshold"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 3
  threshold           = var.autoscaling_low_cpu_threshold

  dimensions = {
    ClusterName = data.aws_ecs_cluster.this.cluster_name
    ServiceName = aws_ecs_service.this.name
  }

  alarm_actions = [aws_appautoscaling_policy.scale_down.arn]
}
