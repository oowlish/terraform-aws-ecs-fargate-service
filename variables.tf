variable "name" {
  type        = string
  description = "Name of the ECS Service."
}

variable "stage" {
  type        = string
  description = "Stage of the ECS Service, e.g staging, beta, qa, prod."
}

variable "tags" {
  type        = map(string)
  description = "Key-value map of resource tags."
}

variable "vpc_id" {
  type        = string
  description = "The identifier of the VPC in which to create the resources."
}

variable "private_subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of private subnets."
}

variable "public_subnet_ids" {
  type        = list(string)
  default     = []
  description = "A list of public subnets."
}

variable "fargate_platform_version" {
  type        = string
  default     = "LATEST"
  description = "The platform version on which to run your service."
}

variable "ecs_assign_public_ip" {
  type        = bool
  default     = false
  description = "Whether to assign a public IP to the Fargate tasks."
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of an existing ECS Cluster."
}

variable "ecs_deployment_controller_type" {
  type        = string
  default     = "ECS"
  description = "Type of deployment controller. Valid values: CODE_DEPLOY, ECS, EXTERNAL. Default: ECS."
}

variable "ecs_container_name" {
  type        = string
  description = "The container name value, already specified in the task definition, to be used for your service discovery service."
}

variable "ecs_container_port" {
  type        = number
  default     = 80
  description = "The port value, already specified in the task definition, to be used for your service discovery service."
}

variable "ecs_deployment_maximum_percent" {
  type        = number
  default     = 200
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment."
}

variable "ecs_deployment_minimum_healthy_percent" {
  type        = number
  default     = 100
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
}

variable "ecs_desired_count" {
  type        = number
  default     = 2
  description = "The number of instances of the task definition to place and keep running."
}

variable "ecs_health_check_grace_period_seconds" {
  type        = number
  default     = 0
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647."
}

variable "ecs_security_group_ids" {
  type        = list(string)
  description = "A list of security groups associated with the task or service."
}

variable "ecs_task_definition_arn" {
  type        = string
  description = "The family and revision (family:revision) or full ARN of the task definition that you want to run in your service."
}

variable "lb_health_check_enabled" {
  type        = bool
  default     = true
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
}

variable "lb_health_check_healthy_threshold" {
  type        = number
  default     = 3
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
}

variable "lb_health_check_interval" {
  type        = number
  default     = 30
  description = "The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds."
}

variable "lb_health_check_matcher" {
  type        = string
  default     = "200-299"
  description = "The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, \"200,202\") or a range of values (for example, \"200-299\")."
}

variable "lb_health_check_path" {
  type        = string
  default     = "/"
  description = "The destination for the health check request."
}

variable "lb_health_check_timeout" {
  type        = number
  default     = 5
  description = "The amount of time, in seconds, during which no response means a failed health check. The range is 2 to 120 seconds, and the default is 5 seconds."
}

variable "lb_health_check_unhealthy_threshold" {
  type        = number
  default     = 3
  description = "The number of consecutive health check failures required before considering the target unhealthy."
}

variable "lb_certificate_arn" {
  type        = string
  default     = ""
  description = "The ARN of the default SSL server certificate."
}

variable "lb_extra_certificates_arn" {
  type        = list(string)
  default     = []
  description = "List of extra SSL server certificates."
}

variable "lb_ssl_policy" {
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  description = "The name of the SSL Policy for the listener."
}

variable "appautoscaling_high_cpu_threshold" {
  type        = number
  default     = 65
  description = "The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models."
}

variable "appautoscaling_low_cpu_threshold" {
  type        = number
  default     = 15
  description = "The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models."
}

variable "appautoscaling_max_capacity" {
  type        = number
  default     = 10
  description = "The max capacity of the scalable target."
}

variable "appautoscaling_min_capacity" {
  type        = number
  default     = 2
  description = "The min capacity of the scalable target."
}

variable "appautoscaling_scale_down_adjustment" {
  type        = number
  default     = -1
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down."
}

variable "appautoscaling_scale_down_cooldown" {
  type        = number
  default     = 150
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
}

variable "appautoscaling_scale_up_adjustment" {
  type        = number
  default     = 2
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down."
}

variable "appautoscaling_scale_up_cooldown" {
  type        = number
  default     = 60
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
}
