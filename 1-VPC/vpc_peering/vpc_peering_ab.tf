# VPC Peering
resource "aws_vpc_peering_connection" "peer_a_b" {
  provider = aws.reg_a
  # peer_owner_id = var.peer_owner_id // If VPC B is in a different account
  vpc_id      = var.vpc_a_id
  peer_vpc_id = var.vpc_b_id
  # auto_accept = true // Used for same-account peering; set to false for cross-account
  peer_region = "us-east-2" # Ohio region for VPC B
  tags        = { Name = "VPC A peering VPC B" }
}

# VPC A: Route to VPC B
resource "aws_route" "vpc_a_to_b" {
  provider                  = aws.reg_a
  route_table_id            = var.vpc_a_private_rt_id
  destination_cidr_block    = var.vpc_b_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_a_b.id
}

# VPC B: Route to VPC A
resource "aws_route" "vpc_b_to_a" {
  provider                  = aws.reg_b
  route_table_id            = var.vpc_b_private_rt_id
  destination_cidr_block    = var.vpc_a_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_a_b.id
}
