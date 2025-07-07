
# # Ubuntu Instances
# locals {
#   ubuntu_instances = {
#     "ubuntu-1" = {
#       private_ip = "10.0.1.300"
#       subnet_id  = var.public_subnet[0]
#     }
#     "ubuntu-2" = {
#       private_ip = "10.0.1.301"
#       subnet_id  = var.public_subnet[0]
#     }
#   }
# }

# resource "aws_instance" "ubuntu" {
#   for_each = local.ubuntu_instances

#   ami                         = var.ami_free_ubuntu
#   instance_type               = var.instance_type_free
#   subnet_id                   = each.value.subnet_id
#   vpc_security_group_ids      = [var.security_group["sg_linux"]]
#   key_name                    = var.private_key_name
#   private_ip                  = each.value.private_ip
#   associate_public_ip_address = false

#   tags = {
#     Name = "limtruong-${each.key}"
#     Backup = "true"
#   }
# }

# resource "aws_eip" "ubuntu_eip" {
#   for_each = aws_instance.ubuntu

#   instance = each.value.id
#   domain   = "vpc"

#   tags = {
#     Name = "ubuntu-eip-${each.key}"
#   }
# }
