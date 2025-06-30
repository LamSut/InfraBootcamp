resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = [var.private_subnet_1, var.private_subnet_2]
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = 10
  db_name                = "limdb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "limtruong"
  password               = "limkhietngoingoi"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.security_group]
  parameter_group_name   = aws_db_parameter_group.mysql_params.name
  skip_final_snapshot    = true // No final snapshot before deletion
  publicly_accessible    = false
  # Backup every week
  backup_retention_period = 7
  backup_window           = "18:00-19:00"
}

output "mysql_identifier" {
  value = aws_db_instance.mysql.identifier
}

output "mysql_endpoint" {
  value = split(":", aws_db_instance.mysql.endpoint)[0]
}



