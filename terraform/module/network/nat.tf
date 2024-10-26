resource "aws_eip" "ecs_eip" {
  vpc = true

  tags = {
    "Name" = format("%s-elastic-ip", var.cluster_name)
  }
}

resource "aws_nat_gateway" "ecs_nat_gw" {
  allocation_id = aws_eip.ecs_eip.id
  subnet_id     = aws_subnet.ecs_subnet_public_1a.id

  tags = {
    Name = format("%s-nat-gateway", var.cluster_name)
  }
}

resource "aws_route_table" "ecs_nat_rt" {
  vpc_id = aws_vpc.ecs_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ecs_nat_gw.id
  }

  tags = {
    Name = format("%s-private-rt", var.cluster_name)
  }
}
