resource "aws_instance" "windows_sqlserver" {
  ami                         = var.ami_free_windows
  instance_type               = var.instance_type_free
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
