# VPC A config
resource "aws_vpc" "vpc_a" {
  provider   = aws.reg_a
  cidr_block = "10.10.0.0/16"
  tags       = { Name = "VPC A" }
}

resource "aws_subnet" "vpc_a_private_1" {
  provider          = aws.reg_a
  vpc_id            = aws_vpc.vpc_a.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  tags              = { Name = "VPC A - Private Subnet 1" }
}

resource "aws_subnet" "vpc_a_private_2" {
  provider          = aws.reg_a
  vpc_id            = aws_vpc.vpc_a.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "us-east-1b"
  tags              = { Name = "VPC A - Private Subnet 2" }
}

resource "aws_subnet" "vpc_a_public_1" {
  provider                = aws.reg_a
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = "10.10.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags                    = { Name = "VPC A - Public Subnet 1" }
}

resource "aws_subnet" "vpc_a_public_2" {
  provider                = aws.reg_a
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = "10.10.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags                    = { Name = "VPC A - Public Subnet 2" }
}
