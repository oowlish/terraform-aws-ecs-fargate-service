terraform {
  required_version = "~> 0.12"
}

locals {
  name_prefix = "${var.name}-${var.environment_short}"

  tags = {
    Application = var.name
    Environment = var.environment
    Terraform   = "yes"
  }
}
