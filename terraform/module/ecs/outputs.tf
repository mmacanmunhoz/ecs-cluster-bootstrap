output "public_alb_dns_name" {
  value       = aws_alb.public_alb[*].dns_name
  description = "DNS Name do ALB público"
}

output "internal_alb_dns_name" {
  value       = aws_alb.internal_alb[*].dns_name
  description = "DNS Name do ALB interno"
}

output "public_alb_name" {
  value       = aws_alb.public_alb[*].name
  description = "Nome do ALB público"
}

output "internal_alb_name" {
  value       = aws_alb.internal_alb[*].name
  description = "Nome do ALB interno"
}

output "public_alb_arn" {
  value       = aws_alb.public_alb[*].arn
  description = "ARN do ALB público"
}

output "internal_alb_arn" {
  value       = aws_alb.internal_alb[*].arn
  description = "ARN do ALB interno"
}

output "ecs_cluster_id" {
  value       = aws_ecs_cluster.this.id
  description = "ID do cluster ECS"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.this.name
  description = "Nome do cluster ECS"
}

output "http_public_lb_listener_arn" {
  description = "ARN do listener HTTP público do ALB."
  value       = aws_lb_listener.http_public[*].arn
}

output "http_private_lb_listener_arn" {
  description = "ARN do listener HTTP privado do ALB."
  value       = aws_lb_listener.http_private[*].arn
}

output "https_public_lb_listener_arn" {
  description = "ARN do listener HTTPS público do ALB."
  value       = aws_lb_listener.https_public[*].arn
}

output "https_private_lb_listener_arn" {
  description = "ARN do listener HTTPS privado do ALB."
  value       = aws_lb_listener.https_private[*].arn
}