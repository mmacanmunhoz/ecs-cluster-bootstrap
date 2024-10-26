variable "name-ecs" {
  description = "Nome do cluster ECS"
  type        = string
}

variable "internal" {
  description = "Se vamos ter o ALB interno"
  type        = bool
  default     = false
}

variable "public" {
  description = "Se vamos ter o ALB publico"
  type        = bool
  default     = true
}

variable "subnets_private" {
  description = "Lista de subnets privadas ou públicas, dependendo do tipo de ALB"
  type        = list(string)
  default     = []
}

variable "subnets_public" {
  description = "Lista de subnets privadas ou públicas, dependendo do tipo de ALB"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "Id da VPC para o security group"
  type        = string
}

variable "certificate_arn" {
  description = "Certificado ACM do Listener HTTPS"
  type        = string
  default     = ""
}

variable "enable_listener_https" {
  description = "Habilita o Listener HTTPS"
  type        = bool
  default     = true
}