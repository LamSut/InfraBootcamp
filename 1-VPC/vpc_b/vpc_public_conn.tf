# IGW for VPC B
resource "aws_internet_gateway" "igw_b" {
  provider = aws.reg_b
  vpc_id   = aws_vpc.vpc_b.id
  tags     = { Name = "VPC B - IGW" }
}

# Public Route Table for VPC B
resource "aws_route_table" "vpc_b_public_rt" {
  provider = aws.reg_b
  vpc_id   = aws_vpc.vpc_b.id
  tags     = { Name = "VPC B - Public RT" }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_b.id
  }
}

# Route table associations for VPC B public subnets
resource "aws_route_table_association" "vpc_b_public_1_assoc" {
  provider       = aws.reg_b
  subnet_id      = aws_subnet.vpc_b_public_1.id
  route_table_id = aws_route_table.vpc_b_public_rt.id
}

resource "aws_route_table_association" "vpc_b_public_2_assoc" {
  provider       = aws.reg_b
  subnet_id      = aws_subnet.vpc_b_public_2.id
  route_table_id = aws_route_table.vpc_b_public_rt.id
}
