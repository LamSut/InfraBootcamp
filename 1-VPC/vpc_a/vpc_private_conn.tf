# Elastic IP for NAT A
resource "aws_eip" "nat_a_eip" {
  provider = aws.reg_a
  domain   = "vpc"

  tags = {
    Name = "nat_a_eip"
  }
}

# NAT Gateway A
resource "aws_nat_gateway" "nat_a" {
  provider      = aws.reg_a
  allocation_id = aws_eip.nat_a_eip.id
  subnet_id     = aws_subnet.vpc_a_public_1.id
  tags          = { Name = "NAT A" }
}

# Private Route Table for VPC A
resource "aws_route_table" "vpc_a_private_rt" {
  provider = aws.reg_a
  vpc_id   = aws_vpc.vpc_a.id
  tags     = { Name = "VPC A - Private RT" }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_a.id
  }
}

resource "aws_route_table_association" "vpc_a_private_1_assoc" {
  provider       = aws.reg_a
  subnet_id      = aws_subnet.vpc_a_private_1.id
  route_table_id = aws_route_table.vpc_a_private_rt.id
}

resource "aws_route_table_association" "vpc_a_private_2_assoc" {
  provider       = aws.reg_a
  subnet_id      = aws_subnet.vpc_a_private_2.id
  route_table_id = aws_route_table.vpc_a_private_rt.id
}
