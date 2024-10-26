output "vpc_id" {
  value = aws_vpc.ecs_vpc.id
}

output "private_subnet_1a" {
  value = aws_subnet.ecs_subnet_private_1a.id
}

output "private_subnet_1b" {
  value = aws_subnet.ecs_subnet_private_1b.id
}

output "public_subnet_1a" {
  value = aws_subnet.ecs_subnet_public_1a.id
}

output "public_subnet_1b" {
  value = aws_subnet.ecs_subnet_public_1b.id
}