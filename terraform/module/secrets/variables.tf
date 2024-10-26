variable "name" {
  description = "O nome do Secret Manager"
}

variable "description" {
  description = "A descrição do Secret Manager"
  default       = ""
}

variable "tags" {
  description = "As tags para o Secret Manager"
  type        = map(string)
  default     = {}
}

variable "secrets" {
  description = "Um mapa de segredos a serem armazenados no Secret Manager"
  type        = map(string)
  default     = {}
}
