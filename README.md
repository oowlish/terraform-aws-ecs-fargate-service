# Terraform AWS ECS Fargate Service

## Usage

```tf
resource "aws_ecs_task_definition" "this" {
  family = "wordpress"

  container_definitions = file("task-definitions/wordpress.json")

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 256
  memory = 512
}

module "ecs_fargate_service" {
  source  = "app.terraform.io/oowlish/ecs-fargate-service/aws"
  version = "~> 0.1"

  name = "wordpress"

  vpc_id             = "vpc-xxxxxx"
  public_subnet_ids  = ["subnet-xxxxxx"]
  private_subnet_ids = ["subnet-xxxxxx"]

  ecs_service_security_group_ids  = ["sg-xxxxxx"]
  ecs_service_task_definition_arn = aws_ecs_task_definition.this.arn

  lb_security_group_ids= ["sg-xxxxxx"]
}
```
