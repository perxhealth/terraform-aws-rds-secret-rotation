output "secret_arn" {
  value = try(aws_secretsmanager_secret.this[0].arn, data.aws_secretsmanager_secret.this.arn)
}

output "secret_name" {
  value = try(aws_secretsmanager_secret.this[0].name, data.aws_secretsmanager_secret.this.name)
}

output "secret_id" {
  value = try(aws_secretsmanager_secret.this[0].id, data.aws_secretsmanager_secret.this.id)
}
