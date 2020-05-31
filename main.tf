terraform {
  required_version = "~> 0.12"
}

locals {
  name_prefix = ""
}


data "aws_caller_identity" "current" {}

data "aws_ecs_cluster" "this" {
  cluster_name = var.cluster_name
}
