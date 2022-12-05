locals {
  secret_value_single_user = {
    username            = var.username
    password            = var.password
    engine              = var.engine
    host                = var.host
    port                = var.port
    dbname              = var.dbname
    dbClusterIdentifier = var.db_cluster_identifier
  }
  secret_value_multiuser = {
    username            = var.username
    password            = var.password
    engine              = var.engine
    host                = var.host
    port                = var.port
    dbname              = var.dbname
    masterarn           = var.master_secret_arn
    dbClusterIdentifier = var.db_cluster_identifier
  }
}

data "aws_region" "current" {}

resource "aws_secretsmanager_secret" "this" {
  count                   = var.create_secret ? 1 : 0
  name                    = var.name
  recovery_window_in_days = var.secret_recovery_window_days
}

resource "aws_secretsmanager_secret_version" "this" {
  count          = var.create_secret ? 1 : 0
  secret_id      = aws_secretsmanager_secret.this[count.index].id
  secret_string  = jsonencode(var.rotation_strategy == "single" ? local.secret_value_single_user : local.secret_value_multiuser)

  lifecycle {
    ignore_changes = [
      secret_string,
      version_stages
    ]
  }
}

// To reference when not creating

data "aws_secretsmanager_secret" "this" {
  name = var.name
  depends_on = [aws_secretsmanager_secret.this]
}

// Write permissions

resource "aws_secretsmanager_secret_policy" "write_secret_policy" {
  secret_arn = data.aws_secretsmanager_secret.this.arn
  policy     = data.aws_iam_policy_document.write_secret_policy.json
}

data "aws_iam_policy_document" "write_secret_policy" {

  statement {
    effect = "Allow"
    principals {
      identifiers = var.write_role_arns
      type        = "AWS"
    }
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:PutSecretValue",
      "secretsmanager:UpdateSecretVersionStage"
    ]
    resources = ["*"]
  }
}

// Read Permissions

resource "aws_secretsmanager_secret_policy" "readonly_secret_policy" {
  secret_arn = data.aws_secretsmanager_secret.this.arn
  policy     = data.aws_iam_policy_document.readonly_secret_policy.json
}

data "aws_iam_policy_document" "readonly_secret_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = var.read_role_arns
      type        = "AWS"
    }
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = ["*"]
  }
}