# Backup with manual snapshot
resource "aws_db_snapshot" "mysql_snapshot" {
  db_instance_identifier = aws_db_instance.mysql.identifier
  db_snapshot_identifier = "limsnap"
}
