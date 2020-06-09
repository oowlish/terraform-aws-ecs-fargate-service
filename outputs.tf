output "this_ecs_service_name" {
  value = aws_ecs_service.this.name
}

output "this_lb_dns_name" {
  value = aws_lb.this.dns_name
}
