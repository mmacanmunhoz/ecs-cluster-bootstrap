output "secret_arn" {
    description = "ARN do Segredo"
    value = aws_secretsmanager_secret.this.arn
}