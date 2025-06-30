output "vpc_a_id" {
  value = aws_vpc.vpc_a.id
}

output "vpc_a_cidr_block" {
  value = aws_vpc.vpc_a.cidr_block
}

output "vpc_a_private_rt_id" {
  value = aws_route_table.vpc_a_private_rt.id
}
