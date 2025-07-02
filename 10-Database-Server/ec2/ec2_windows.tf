data "aws_ami" "windows_2022" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-SQL_2022*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["801119661308"]
}

resource "aws_instance" "windows_sqlserver" {
  ami                         = data.aws_ami.windows_2022.id
  instance_type               = "t2.medium"
  subnet_id                   = var.public_subnet
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.windows_sg]
  key_name                    = var.private_key_name

  tags = { Name = "EC2 with SQLServer" }

  user_data = templatefile("${path.module}/windows_sqlserver.tpl", {
    name = "nilhil"
  })
}

output "windows_sqlserver_public_ip" {
  value = aws_instance.windows_sqlserver.public_ip
}
