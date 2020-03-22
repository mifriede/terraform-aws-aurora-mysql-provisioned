# Aurora MySQL (provisioned) Terraform module

Terraform module which creates Aurora MySQL resources on AWS.

## Requiirements

- Terraform version > 0.12

## Usage

```hcl
module "aurora_mysql_provisioned" {
  source = "youyo/aurora-mysql-provisioned/aws"

  name                                   = "my-database"
  master_username                        = "testuser"
  master_password                        = "testpassword"
  availability_zones                     = ["ap-northeast-1a"]
  db_subnet_group_name                   = "db_subnet_group_name"
  vpc_security_group_ids                 = ["sg-xxxxxx"]
  instance_class                         = "db.r5.large"
  instance_count                         = 3
  engine_version                         = "2.07.1"
  database_name                          = "testdatabase"
  port                                   = 3306
  storage_encrypted                      = true
  monitoring_interval                    = 0
  performance_insights_enabled           = true
  enabled_cloudwatch_logs_exports        = ["audit", "error", "general", "slowquery"]
  cloudwatch_log_group_retention_in_days = 400
  copy_tags_to_snapshot                  = true
  skip_final_snapshot                    = true
  backup_retention_period                = 35
  publicly_accessible                    = false
  auto_minor_version_upgrade             = false
  preferred_backup_window                = "15:00-15:30"
  preferred_maintenance_window           = "Sun:20:00-Sun:20:30"
  apply_immediately                      = true

  parameter_group_parameters = [
    {
      name         = "slow_query_log"
      value        = 1
      apply_method = "immediate"
    },
    {
      name         = "long_query_time"
      value        = 1
      apply_method = "immediate"
    },
    {
      name         = "general_log"
      value        = 0
      apply_method = "immediate"
    },
    {
      name         = "log_output"
      value        = "FILE"
      apply_method = "immediate"
    }
  ]

  cluster_parameter_group_parameters = [
    {
      name         = "character_set_server"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_client"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_connection"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_database"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_results"
      value        = "utf8mb4"
      apply_method = "immediate"
    },
    {
      name         = "character_set_filesystem"
      value        = "binary"
      apply_method = "immediate"
    },
    {
      name         = "time_zone"
      value        = "asia/tokyo"
      apply_method = "immediate"
    },
    {
      name         = "skip-character-set-client-handshake"
      value        = 1
      apply_method = "pending-reboot"
    }
  ]

  tags = {
    Env = "production"
  }
}
```
