# Backup
resource "aws_backup_vault" "ec2_backup_vault" {
  name = "ec2-backup-vault"
}

resource "aws_iam_role" "ec2_backup_role" {
  name = "ec2-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "backup.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_backup_policy_attach" {
  role       = aws_iam_role.ec2_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_plan" "ec2_backup_plan" {
  name = "daily-ec2-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.ec2_backup_vault.name
    schedule          = "cron(0 0 * * ? *)" # Backup daily at 00:00 UTC
    start_window      = 60
    completion_window = 180

    lifecycle {
      delete_after = 30 # Keep backups for 30 days
    }
  }
}

resource "aws_backup_selection" "ec2_backup_selection" {
  name         = "ec2-backup-selection"
  iam_role_arn = aws_iam_role.ec2_backup_role.arn
  plan_id      = aws_backup_plan.ec2_backup_plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}

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

# # # Backup AMI for Ubuntu instances
# # resource "aws_ami_from_instance" "ubuntu_backup" {
# #   for_each = aws_instance.ubuntu

# #   name               = "backup-ami-${each.key}-${formatdate("YYYYMMDD", timestamp())}"
# #   source_instance_id = each.value.id
# #   description        = "Backup AMI for ${each.key} created on ${formatdate("YYYY-MM-DD", timestamp())}"
# #   tags = {
# #     Name = "Backup AMI ${each.key}"
# #     Type = "Ubuntu"
# #   }
# # }

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
