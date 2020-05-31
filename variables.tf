variable "name" {
  description = "Name of the ECS Service."
  type        = string
}

variable "environment" {
  description = "Name of the environment, e.g staging, development, production"
  default     = "staging"
  type        = string
}

variable "environment_short" {
  description = "Short name of the environment, e.g stg, dev, prd"
  default     = "stg"
  type        = string
}

variable "vpc_id" {
  description = "The identifier of the VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet identifiers."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "A list of private subnet identifiers."
  type        = list(string)
}

variable "ecs_cluster_name" {
  description = "Name of an ECS cluster."
  type        = string
}

variable "ecs_service_task_definition_arn" {
  description = "The family and revision (family:revision) or full ARN of the task definition that you want to run in your service."
  type        = string
}

variable "ecs_service_desired_count" {
  description = "The number of instances of the task definition to place and keep running."
  type        = number
  default     = 2
}

variable "ecs_service_deployment_maximum_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment."
  type        = number
  default     = 200
}

variable "ecs_service_deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  type        = number
  default     = 100
}

variable "ecs_service_health_check_grace_period_seconds" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647."
  type        = number
  default     = 0
}

variable "ecs_service_container_name" {
  description = "The name of the container to associate with the load balancer (as it appears in a container definition)."
  type        = string
  default     = "nginx"
}

variable "ecs_service_container_port" {
  description = "The port on the container to associate with the load balancer."
  type        = string
  default     = 80
}

variable "ecs_service_security_group_ids" {
  description = "The security groups associated with the task or service."
  type        = list(string)
}

variable "ecs_service_assign_public_ip" {
  description = "Assign a public IP address to the ENI."
  type        = bool
  default     = false
}

variable "autoscaling_min_capacity" {
  description = "The min capacity of the scalable target."
  type        = number
  default     = 2
}

variable "autoscaling_max_capacity" {
  description = "The max capacity of the scalable target."
  type        = number
  default     = 10
}

variable "autoscaling_high_cpu_threshold" {
  description = "The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models."
  type        = number
  default     = 65
}

variable "autoscaling_scale_up_adjustment" {
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down."
  type        = number
  default     = 2
}

variable "autoscaling_scale_up_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
  type        = number
  default     = 60
}

variable "autoscaling_low_cpu_threshold" {
  description = "The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models."
  type        = number
  default     = 10
}

variable "autoscaling_scale_down_adjustment" {
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down."
  type        = number
  default     = -1
}

variable "autoscaling_scale_down_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
  type        = string
  default     = 150
}

variable "lb_security_group_ids" {
  description = "A list of security group IDs to assign to the LB."
  type        = string
}

variable "lb_health_check_enabled" {
  description = "Indicates whether health checks are enabled."
  type        = bool
  default     = true
}

variable "lb_health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds."
  type        = number
  default     = 30
}

variable "lb_health_check_path" {
  description = "The destination for the health check request."
  type        = string
  default     = "/"
}

variable "lb_health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check. The range is 2 to 120 seconds, and the default is 5 seconds."
  type        = number
  default     = 5
}

variable "lb_health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
  type        = number
  default     = 3
}

variable "lb_health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy."
  type        = number
  default     = 3
}

variable "lb_health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, \"200,202\") or a range of values (for example, \"200-299\")."
  type        = string
  default     = "200-299"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
