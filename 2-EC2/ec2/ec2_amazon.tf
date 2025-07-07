# Amazon Linux Instances
locals {
  amazon_linux_instances = {
    "amazon-1" = {
      private_ip = "10.0.1.100"
      subnet_id  = var.public_subnet[0]
    }
    # "amazon-2" = {
    #   private_ip = "10.0.1.101"
    #   subnet_id  = var.public_subnet[0]
    # }
  }
}

resource "aws_instance" "amazon" {
  for_each = local.amazon_linux_instances

  ami                         = var.ami_free_amazon
  instance_type               = var.instance_type_free
  subnet_id                   = each.value.subnet_id
  vpc_security_group_ids      = [var.security_group["sg_linux"]]
  key_name                    = var.private_key_name
  private_ip                  = each.value.private_ip
  associate_public_ip_address = false # we will use EIP

  tags = {
    Name   = "limtruong-${each.key}"
    Backup = "true"
  }
}

resource "aws_eip" "amazon_eip" {
  for_each = aws_instance.amazon

  instance = each.value.id
  domain   = "vpc"

  tags = {
    Name = "amazon-eip-${each.key}"
  }
}

