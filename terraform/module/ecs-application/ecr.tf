module "app-ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.3.0"
  count   = local.application.create_repo == true ? 1 : 0

  repository_name = local.application.app_name

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Manter as últimas 30 imagens"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = var.tags
}
