output "app-execution-role" {
  value       = aws_iam_role.this.name
  description = "Role de execução da aplicação ECS."
}

output "app-service-namespace" {
  value       = aws_appautoscaling_target.this.service_namespace
  description = "Namespace do serviço ECS para autoescalabilidade."
}

output "app-resource-id" {
  value       = aws_appautoscaling_target.this.resource_id
  description = "ID do recurso ECS utilizado para autoescalabilidade."
}

output "app-scalable-dimension" {
  value       = aws_appautoscaling_target.this.scalable_dimension
  description = "Dimensão escalável do serviço ECS."
}

output "container_sg-id" {
  value       = module.container_sg.security_group_id
  description = "ID do grupo de segurança do contêiner."
}
