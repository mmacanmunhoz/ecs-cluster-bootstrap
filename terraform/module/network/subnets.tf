### PRIVATE SUBNET

resource "aws_subnet" "ecs_subnet_private_1a" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = format("%sa", var.region)

  tags = {
    Name                                        = format("%s-subnet-private-1a", var.cluster_name)
    "ecs:cluster"                               = var.cluster_name
  }
}

resource "aws_subnet" "ecs_subnet_private_1b" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = format("%sb", var.region)

  tags = {
    Name                                        = format("%s-subnet-private-1b", var.cluster_name)
    "ecs:cluster"                               = var.cluster_name
  }
}

resource "aws_route_table_association" "ecs_private_rt_association_1a" {
  subnet_id      = aws_subnet.ecs_subnet_private_1a.id
  route_table_id = aws_route_table.ecs_nat_rt.id
}

resource "aws_route_table_association" "ecs_private_rt_association_1b" {
  subnet_id      = aws_subnet.ecs_subnet_private_1b.id
  route_table_id = aws_route_table.ecs_nat_rt.id
}

### PUBLIC SUBNET

resource "aws_subnet" "ecs_subnet_public_1a" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = format("%sa", var.region)
  map_public_ip_on_launch = true

  tags = {
    Name                                        = format("%s-subnet-public-1a", var.cluster_name)
    "ecs:cluster"                               = var.cluster_name
  }
}

resource "aws_subnet" "ecs_subnet_public_1b" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = format("%sb", var.region)
  map_public_ip_on_launch = true

  tags = {
    Name                                        = format("%s-subnet-public-1b", var.cluster_name)
    "ecs:cluster"                               = var.cluster_name
  }
}

resource "aws_route_table_association" "ecs_public_rt_association_1a" {
  subnet_id      = aws_subnet.ecs_subnet_public_1a.id
  route_table_id = aws_route_table.ecs_public_rt.id
}

resource "aws_route_table_association" "ecs_public_rt_association_1b" {
  subnet_id      = aws_subnet.ecs_subnet_public_1b.id
  route_table_id = aws_route_table.ecs_public_rt.id
}
