data "aws_iam_policy_document" "ecs-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name = "${local.application.app_name}-task-role"
  path = "/"

  assume_role_policy = data.aws_iam_policy_document.ecs-assume-role.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "app-execution-role-AmazonEC2ContainerServiceRole-attachment" {
  role       = local.application.ecs_execution_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_role_policy_attachment" "app-execution-role-AmazonECSTaskExecutionRolePolicy-attachment" {
  role       = local.application.ecs_execution_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
