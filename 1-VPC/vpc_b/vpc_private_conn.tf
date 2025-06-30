# Elastic IP for NAT B
resource "aws_eip" "nat_b_eip" {
  provider = aws.reg_b
  domain   = "vpc"

  tags = {
    Name = "nat_b_eip"
  }
}

# NAT Gateway B
resource "aws_nat_gateway" "nat_b" {
  provider      = aws.reg_b
  allocation_id = aws_eip.nat_b_eip.id
  subnet_id     = aws_subnet.vpc_b_public_1.id
  tags          = { Name = "NAT B" }
}

# Private Route Table for VPC B
resource "aws_route_table" "vpc_b_private_rt" {
  provider = aws.reg_b
  vpc_id   = aws_vpc.vpc_b.id
  tags     = { Name = "VPC B - Private RT" }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_b.id
  }
}

resource "aws_route_table_association" "vpc_b_private_1_assoc" {
  provider       = aws.reg_b
  subnet_id      = aws_subnet.vpc_b_private_1.id
  route_table_id = aws_route_table.vpc_b_private_rt.id
}

resource "aws_route_table_association" "vpc_b_private_2_assoc" {
  provider       = aws.reg_b
  subnet_id      = aws_subnet.vpc_b_private_2.id
  route_table_id = aws_route_table.vpc_b_private_rt.id
}
