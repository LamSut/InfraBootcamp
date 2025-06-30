# IGW for VPC A
resource "aws_internet_gateway" "igw_a" {
  provider = aws.reg_a
  vpc_id   = aws_vpc.vpc_a.id
  tags     = { Name = "VPC A - IGW" }
}

# Public Route Table for VPC A
resource "aws_route_table" "vpc_a_public_rt" {
  provider = aws.reg_a
  vpc_id   = aws_vpc.vpc_a.id
  tags     = { Name = "VPC A - Public RT" }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }
}

# Route table associations for VPC A public subnets
resource "aws_route_table_association" "vpc_a_public_1_assoc" {
  provider       = aws.reg_a
  subnet_id      = aws_subnet.vpc_a_public_1.id
  route_table_id = aws_route_table.vpc_a_public_rt.id
}

resource "aws_route_table_association" "vpc_a_public_2_assoc" {
  provider       = aws.reg_a
  subnet_id      = aws_subnet.vpc_a_public_2.id
  route_table_id = aws_route_table.vpc_a_public_rt.id
}
