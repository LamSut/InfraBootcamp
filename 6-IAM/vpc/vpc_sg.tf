# EC2 allow SSH access
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.limtruong_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS allow MySQL access from EC2 only
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow MySQL from EC2 only"
  vpc_id      = aws_vpc.limtruong_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
