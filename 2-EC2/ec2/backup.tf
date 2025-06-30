# Backup AMI for Amazon Linux instances
resource "aws_ami_from_instance" "amazon_backup" {
  for_each = aws_instance.amazon

  name               = "backup-ami-${each.key}-${formatdate("YYYYMMDD", timestamp())}"
  source_instance_id = each.value.id
  description        = "Backup AMI for ${each.key} created on ${formatdate("YYYY-MM-DD", timestamp())}"
  tags = {
    Name = "Backup AMI ${each.key}"
    Type = "Amazon Linux"
  }
}

# # Backup AMI for Ubuntu instances
# resource "aws_ami_from_instance" "ubuntu_backup" {
#   for_each = aws_instance.ubuntu

#   name               = "backup-ami-${each.key}-${formatdate("YYYYMMDD", timestamp())}"
#   source_instance_id = each.value.id
#   description        = "Backup AMI for ${each.key} created on ${formatdate("YYYY-MM-DD", timestamp())}"
#   tags = {
#     Name = "Backup AMI ${each.key}"
#     Type = "Ubuntu"
#   }
# }

# Backup AMI for Windows instances
resource "aws_ami_from_instance" "windows_backup" {
  for_each = aws_instance.windows

  name               = "backup-ami-${each.key}-${formatdate("YYYYMMDD", timestamp())}"
  source_instance_id = each.value.id
  description        = "Backup AMI for ${each.key} created on ${formatdate("YYYY-MM-DD", timestamp())}"
  tags = {
    Name = "Backup AMI ${each.key}"
    Type = "Windows"
  }
}
