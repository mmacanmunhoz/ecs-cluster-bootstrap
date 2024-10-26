variable "application" {
  description = "Configuração da Aplicação do ECS"
  type        = any
  default     = {}
}

variable "vpc_id" {
  description = "ID da VPC onde a aplicação será implantada."
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "IDs das subnets onde a aplicação será implantada."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags a serem aplicadas aos recursos criados."
  type        = map(string)
  default     = null
}

variable "external_domain" {
  description = "Flag para indicar se a aplicação usará um domínio externo."
  type        = bool
  default     = false
}

variable "external_domain_url" {
  description = "URL do domínio externo que será usado pela aplicação."
  type        = string
  default     = ""
}

variable "app_env" {
  description = "Ambiente da aplicação, como desenvolvimento, homologação ou produção."
  type        = string
  default     = "development"
}

variable "app_hostname" {
  description = "Hostname da aplicação."
  type        = string
  default     = ""
}

variable "route53_id" {
  description = "Id do Route53 para vincular o DNS"
  type        = string
  default     = ""
}

variable "enable_cloudfront" {
  description = "Se desejo habilitar o cloudfront (será desabilitado o Route53 para record do alb)"
  type        = bool
  default     = false
}