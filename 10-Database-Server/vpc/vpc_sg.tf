# Linux allow SSH access
resource "aws_security_group" "linux_sg" {
  name        = "linux_sg"
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

# Windows allow RDP access
resource "aws_security_group" "windows_sg" {
  name        = "windows_sg"
  description = "Allow RDP"
  vpc_id      = aws_vpc.limtruong_vpc.id

  ingress {
    from_port   = 3389
    to_port     = 3389
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

