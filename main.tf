resource "aws_db_parameter_group" "this" {
  name   = "${var.name}-aurora-mysql57"
  family = "aurora-mysql5.7"

  dynamic "parameter" {
    for_each = var.parameter_group_parameters
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = parameter.value["apply_method"]
    }
  }

  tags = merge(
    {
      "Name" = "${var.name}-aurora-mysql57"
    },
    var.tags
  )
}

resource "aws_rds_cluster_parameter_group" "this" {
  name   = "${var.name}-aurora-mysql57"
  family = "aurora-mysql5.7"

  dynamic "parameter" {
    for_each = var.cluster_parameter_group_parameters
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = parameter.value["apply_method"]
    }
  }

  tags = merge(
    {
      "Name" = "${var.name}-aurora-mysql57"
    },
    var.tags
  )
}

resource "aws_db_option_group" "this" {
  name                 = var.name
  engine_name          = "aurora-mysql"
  major_engine_version = "5.7"

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_cloudwatch_log_group" "this" {
  for_each = toset(var.enabled_cloudwatch_logs_exports)

  name              = "/aws/rds/cluster/${aws_rds_cluster.this.id}/${each.value}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days

  tags = merge(
    {
      "Name" = "${var.name}-${each.value}"
    },
    var.tags
  )
}

resource "aws_rds_cluster" "this" {
  cluster_identifier              = var.name
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  skip_final_snapshot             = var.skip_final_snapshot
  availability_zones              = var.availability_zones
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  port                            = var.port
  vpc_security_group_ids          = var.vpc_security_group_ids
  storage_encrypted               = var.storage_encrypted
  apply_immediately               = var.apply_immediately
  db_subnet_group_name            = var.db_subnet_group_name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.id
  engine                          = "aurora-mysql"
  engine_version                  = "5.7.mysql_aurora.${var.engine_version}"
  engine_mode                     = "provisioned"
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )

  depends_on = [
    aws_rds_cluster_parameter_group.this
  ]
}

resource "aws_rds_cluster_instance" "this" {
  count = var.instance_count

  identifier                   = "${var.name}-${count.index}"
  cluster_identifier           = aws_rds_cluster.this.id
  engine                       = "aurora-mysql"
  engine_version               = "5.7.mysql_aurora.${var.engine_version}"
  instance_class               = var.instance_class
  publicly_accessible          = var.publicly_accessible
  db_subnet_group_name         = var.db_subnet_group_name
  db_parameter_group_name      = aws_db_parameter_group.this.id
  apply_immediately            = var.apply_immediately
  promotion_tier               = count.index
  preferred_maintenance_window = var.preferred_maintenance_window
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  copy_tags_to_snapshot        = var.copy_tags_to_snapshot
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = aws_iam_role.this.arn

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )

  depends_on = [
    aws_db_parameter_group.this,
    aws_rds_cluster.this
  ]

}

data "aws_iam_policy_document" "monitoring_rds_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "monitoring.rds.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.name}-rds-enhanced-monitoring"
  assume_role_policy = data.aws_iam_policy_document.monitoring_rds_assume_role.json

  tags = merge(
    {
      "Name" = "${var.name}-rds-enhanced-monitoring"
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
