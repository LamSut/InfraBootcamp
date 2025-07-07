resource "aws_db_parameter_group" "mysql_params" {
  name   = "mysql-slow-log"
  family = "mysql8.0"

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "1"
  }

  parameter {
    name  = "log_output"
    value = "FILE" // Options: FILE or TABLE
  }

  parameter {
    name  = "log_queries_not_using_indexes"
    value = "0" // Set 1 to log queries that do not use indexes
  }
}
