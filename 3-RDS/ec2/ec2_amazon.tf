resource "aws_instance" "ec2" {
  ami                         = var.ami_free_amazon
  instance_type               = var.instance_type_free
  subnet_id                   = var.public_subnet
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group]
  key_name                    = var.private_key_name

  tags = { Name = "EC2_for_RDS" }

  user_data = templatefile("${path.module}/amazon_mysql.tpl", {
    endpoint = var.mysql_endpoint, name = "nilhil"
  })
}
