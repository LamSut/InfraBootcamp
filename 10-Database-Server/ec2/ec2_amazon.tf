# resource "aws_instance" "amazon_mysql" {
#   ami                         = var.ami_free_amazon
#   instance_type               = var.instance_type_free
#   subnet_id                   = var.public_subnet
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [var.linux_sg]
#   key_name                    = var.private_key_name

#   tags = { Name = "EC2 with MySQL" }

#   user_data = templatefile("${path.module}/amazon_mysql.tpl", {
#     name = "nilhil"
#   })
# }

# output "amazon_mysql_public_ip" {
#   value = aws_instance.amazon_mysql.public_ip
# }
