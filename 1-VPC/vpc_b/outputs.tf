output "vpc_b_id" {
  value = aws_vpc.vpc_b.id
}

output "vpc_b_cidr_block" {
  value = aws_vpc.vpc_b.cidr_block
}

output "vpc_b_private_rt_id" {
  value = aws_route_table.vpc_b_private_rt.id
}
