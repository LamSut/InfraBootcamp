#VPC
resource "aws_vpc" "limtruong_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "limtruong_vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  for_each                = { for idx, subnet in var.public_subnets : idx => subnet }
  vpc_id                  = aws_vpc.limtruong_vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true
  availability_zone       = each.value.availability_zone

  tags = {
    Name = "public_subnet_${each.key}"
  }
}

resource "aws_internet_gateway" "limtruong_vpc_igw" {
  vpc_id = aws_vpc.limtruong_vpc.id

  tags = {
    Name = "vpc_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.limtruong_vpc.id

  route {
    cidr_block = var.default_cidr
    gateway_id = aws_internet_gateway.limtruong_vpc_igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

# # Private Subnets
# resource "aws_subnet" "private_subnets" {
#   for_each                = { for idx, subnet in var.private_subnets : idx => subnet }
#   vpc_id                  = aws_vpc.limtruong_vpc.id
#   cidr_block              = each.value.cidr_block
#   map_public_ip_on_launch = false
#   availability_zone       = each.value.availability_zone

#   tags = {
#     Name = "private_subnet_${each.key}"
#   }
# }

# resource "aws_eip" "nat_eip" {
#   domain = "vpc"

#   tags = {
#     Name = "nat_eip"
#   }
# }

# resource "aws_nat_gateway" "nat_gw" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public_subnets["0"].id
#   depends_on    = [aws_internet_gateway.limtruong_vpc_igw]

#   tags = {
#     Name = "nat_gateway"
#   }
# }

# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.limtruong_vpc.id

#   route {
#     cidr_block     = var.default_cidr
#     nat_gateway_id = aws_nat_gateway.nat_gw.id
#   }

#   tags = {
#     Name = "private_route_table"
#   }
# }

# resource "aws_route_table_association" "private_assoc" {
#   for_each = aws_subnet.private_subnets

#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private_rt.id
# }
