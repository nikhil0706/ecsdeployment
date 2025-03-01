output "ecs_service_name" {
  value = aws_ecs_service.app_service.name
}

output "load_balancer_url" {
  value = data.aws_lb.existing_lb.dns_name
}

output "task_definition_arn" {
  value = data.aws_ecs_task_definition.existing_task.arn
}
