variable "name" {
  description = "The name of created resources"
  type        = string
}

variable "create_secret" {
  description = "If the module should create a secret"
  default = true
  type = bool
}

variable "db_cluster_identifier" {
  description = "The DB cluster identifier"
  type        = string
}

variable "username" {
  description = "The username"
  type        = string
}

variable "password" {
  description = "The password for the user"
  type        = string
}

variable "engine" {
  description = "The database engine type"
  type        = string
}

variable "host" {
  description = "The host name of the database instance"
  type        = string
}

variable "port" {
  description = "The port number of the database instance"
  type        = number
}

variable "dbname" {
  description = "The DB name"
  type        = string
}

variable "secret_recovery_window_days" {
  description = "The number of days that Secrets Manager waits before deleting a secret"
  type        = number
  default     = 0
}

variable "rotation_strategy" {
  description = <<EOT
Specifies how the secret is rotated, either by updating credentials for the user itself (single) or by using a
superuser's credentials to change another user's credentials (multiuser).
EOT
  type        = string
  default     = "single"
}



variable "master_secret_arn" {
  description = "The superuser credentials used to update another secret in the multiuser rotation strategy."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to use for created resources"
  type        = map(string)
  default     = {}
}

variable "read_role_arns" {
  type = list(string)
}

variable "write_role_arns" {
  type = list(string)
}