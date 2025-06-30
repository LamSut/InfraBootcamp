# Allow all traffic from VPC B to VPC A instances
# resource "aws_security_group" "allow_vpc_b" {
#   name        = "allow-vpc-b"
#   description = "Allow all traffic from VPC B"
#   vpc_id      = var.vpc_a_id

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = [var.vpc_b_cidr_block]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = { Name = "Allow VPC B" }
# }

# 10.10.1.100 able connect 10.20.1.200 with all port (for VPC A)
resource "aws_security_group" "a_allow_b" {
  provider    = aws.reg_a
  name        = "allow_vpc_b"
  description = "Allow all traffic from 10.20.1.200 (VPC B)"
  vpc_id      = var.vpc_a_id

  ingress {
    description = "Allow all traffic from 10.20.1.200"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.20.1.200/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "Allow VPC B" }
}

resource "aws_security_group" "b_allow_a" {
  provider    = aws.reg_b
  name        = "allow_vpc_a"
  description = "Allow all traffic from 10.10.1.100 (VPC A)"
  vpc_id      = var.vpc_b_id

  ingress {
    description = "Allow all traffic from 10.10.1.100"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.1.100/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "Allow VPC A" }
}
