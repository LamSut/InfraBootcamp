# Windows Instances
locals {
  windows_instances = {
    "windows-1" = {
      private_ip = "10.0.1.200"
      subnet_id  = var.public_subnet[0]
    }
    # "windows-2" = {
    #   private_ip = "10.0.1.201"
    #   subnet_id  = var.public_subnet[0]
    # }
  }
}

resource "aws_instance" "windows" {
  for_each = local.windows_instances

  ami                         = var.ami_free_windows
  instance_type               = var.instance_type_free
  subnet_id                   = each.value.subnet_id
  vpc_security_group_ids      = [var.security_group["sg_windows"]]
  key_name                    = var.private_key_name
  private_ip                  = each.value.private_ip
  associate_public_ip_address = false

  tags = {
    Name = "Lim Truong Windows ${each.key}"
  }
}

resource "aws_eip" "windows_eip" {
  for_each = aws_instance.windows

  instance = each.value.id
  domain   = "vpc"

  tags = {
    Name = "windows-eip-${each.key}"
  }
}
