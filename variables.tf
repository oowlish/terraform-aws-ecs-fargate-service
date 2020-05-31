variable "lb_security_group_ids" {
  description = "A list of security group identifiers to associate to the Load Balancer."
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "A list of public subnet identifiers."
  type        = list(string)
}

variable "vpc_id" {
  description = "The identifier of the VPC."
  type        = string
}

variable "target_group_port" {
  description = "The port to use to connect with the target. Valid values are either ports 1-65535, or traffic-port."
  type        = number
  default     = 80
}

variable "target_group_health_check_enabled" {
  description = "Indicates whether health checks are enabled."
  type        = bool
  default     = true
}

variable "target_group_health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. Default 30 seconds."
  type        = number
  default     = 30
}

variable "target_group_health_check_path" {
  description = "The destination for the health check request."
  type        = string
  default     = "/"
}

variable "target_group_health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check. The range is 2 to 120 seconds, and the default is 5 seconds."
  type        = number
  default     = 5
}

variable "target_group_health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
  type        = number
  default     = 3
}

variable "target_group_health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy."
  type        = number
  default     = 3
}

variable "target_group_health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, \"200,202\") or a range of values (for example, \"200-299\")."
  type        = string
  default     = "200-299"
}


# variable "name" {
#   description = "The name of the service."
#   type        = string
# }

# variable "cluster_name" {
#   description = "The name of an ECS cluster to deploy the service in."
#   type        = string
# }

# variable "network" {
#   type = object({
#     vpc_id             = string
#     public_subnet_ids  = list(string)
#     private_subnet_ids = list(string)
#   })
# }

# variable "settings" {
#   type = object({
#     container_definitions = string

#     exposed_container = string
#     exposed_port      = number

#     cpu    = number
#     memory = number

#     health_check_path    = string
#     health_check_matcher = string
#   })
# }


# variable "autoscaling" {
#   type = object({
#     min_capacity = number
#     max_capacity = number

#     high_cpu_threshold  = number
#     scale_up_cooldown   = number
#     scale_up_adjustment = number

#     low_cpu_threshold     = number
#     scale_down_cooldown   = number
#     scale_down_adjustment = number
#   })
# }

# variable "tags" {
#   description = "A map of tags to add to all resources."
#   type        = map(string)
# }
