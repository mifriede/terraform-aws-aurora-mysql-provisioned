variable "name" {
  type        = string
  description = "A name for your database"
}
variable "parameter_group_parameters" {
  type        = list(map(string))
  description = "DB parameter group resource parameters"
  default = [
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
}

variable "cluster_parameter_group_parameters" {
  type        = list(map(string))
  description = "Cluster parameter group resource parameters"
  default = [
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
}
variable "cloudwatch_log_group_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
  default     = 400
}
variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy all Cluster tags to snapshots"
  default     = true
}
variable "database_name" {
  type        = string
  description = "Database name"
  default     = ""
}
variable "master_username" {
  type        = string
  description = "Username for the master DB user"
}
variable "master_password" {
  type        = string
  description = "Password for the master DB user"
}
variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  default     = true
}
variable "availability_zones" {
  type        = list(string)
  description = "A list of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created"
}
variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for"
  default     = 35
}
variable "preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter"
  default     = "15:00-15:30"
}
variable "preferred_maintenance_window" {
  type        = string
  description = "The weekly time range during which system maintenance can occur, in (UTC)"
  default     = "Sun:20:00-Sun:20:30"
}
variable "port" {
  type        = number
  description = "The port on which the DB accepts connections"
  default     = 3306
}
variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security groups to associate with the Cluster"
  default     = []
}
variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB cluster is encrypted"
  default     = true
}
variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default     = true
}
variable "engine_version" {
  type        = string
  description = "The database engine version"
  default     = "2.07.1"
}
variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to export to cloudwatch"
  default     = ["audit", "error", "general", "slowquery"]
}
variable "instance_count" {
  type        = number
  description = "Number of cluster member"
  default     = 2
}
variable "instance_class" {
  type        = string
  description = "The instance class to use"
  default     = "db.r5.large"
}
variable "publicly_accessible" {
  type        = bool
  description = "Bool to control if instance is publicly accessible"
  default     = false
}
variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = false
}
variable "performance_insights_enabled" {
  type        = bool
  description = "Specifies whether Performance Insights is enabled or not"
  default     = true
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource"
}
variable "db_subnet_group_name" {
  type        = string
  description = "A DB subnet group to associate with this DB instance"
}
variable "monitoring_interval" {
  type        = number
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}
