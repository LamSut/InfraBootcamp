# VPC B config
resource "aws_vpc" "vpc_b" {
  provider   = aws.reg_b
  cidr_block = "10.20.0.0/16"
  tags       = { Name = "VPC B" }
}

resource "aws_subnet" "vpc_b_private_1" {
  provider          = aws.reg_b
  vpc_id            = aws_vpc.vpc_b.id
  cidr_block        = "10.20.1.0/24"
  availability_zone = "us-east-2a"
  tags              = { Name = "VPC B - Private Subnet 1" }
}

resource "aws_subnet" "vpc_b_private_2" {
  provider          = aws.reg_b
  vpc_id            = aws_vpc.vpc_b.id
  cidr_block        = "10.20.2.0/24"
  availability_zone = "us-east-2b"
  tags              = { Name = "VPC B - Private Subnet 2" }
}

resource "aws_subnet" "vpc_b_public_1" {
  provider                = aws.reg_b
  vpc_id                  = aws_vpc.vpc_b.id
  cidr_block              = "10.20.3.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags                    = { Name = "VPC B - Public Subnet 1" }
}

resource "aws_subnet" "vpc_b_public_2" {
  provider                = aws.reg_b
  vpc_id                  = aws_vpc.vpc_b.id
  cidr_block              = "10.20.4.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true
  tags                    = { Name = "VPC B - Public Subnet 2" }
}
