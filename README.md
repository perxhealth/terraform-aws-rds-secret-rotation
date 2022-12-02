Forked from https://github.com/JCapriotti/terraform-aws-rds-secret-rotation

# AWS RDS Secret Rotation

A Terraform module that creates an AWS Secrets Manager secret for RDS.

## Features

* Creates secret with the correct format required by RDS.
* Supports PostgreSQL but is easy to add other engines.

Recommended to combine with terraform-aws-rds-secret-rotation-function to get rotation enabled

## Usage

### PostgreSQL Aurora Serverless

```terraform
module "root_user" {
  source = "git::https://bitbucket.org:perxhealth/terraform-aws-rds-secret-rotation"

  db_cluster_identifier = "my-db"
  engine                = "postgres"
  host                  = "my-db.cluster-xxxxxxxx.us-east-1.rds.amazonaws.com"
  name_prefix           = "my-db-"
  port                  = 5432
  username              = "root"
  password              = "SomethingSecret!"
}
```

## Inputs

| Name                                                                                                                     | Description                                                                                                                                                                                  | Type           | Default  | Required |
|--------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|----------|:--------:|
| <a name="input_db_cluster_identifier"></a> [db_cluster_identifier](#input_db_cluster_identifier)                         | The DB cluster identifier                                                                                                                                                                    | `string`       |          |   yes    |
| <a name="input_db_security_group_id"></a> [db_security_group_id](#input_db_security_group_id)                            | The security group ID for the database. Required for secret rotation.                                                                                                                        | `string`       | `null`   |    no    |
| <a name="input_engine"></a> [engine](#input_engine)                                                                      | The database engine type                                                                                                                                                                     | `string`       |          |   yes    |
| <a name="input_host"></a> [host](#input_host)                                                                            | The host name of the database instance                                                                                                                                                       | `string`       |          |   yes    |
| <a name="input_master_secret_arn"></a> [master_secret_arn](#input_master_secret_arn)                                     | The superuser credentials used to update another secret in the multiuser rotation strategy. Required when using `multipleuser` rotation strategy.                                            | `string`       | null     |    no    |
| <a name="input_name_prefix"></a> [name_prefix](#input_name_prefix)                                                       | The prefix for names of created resources.                                                                                                                                                   | `string`       |          |   yes    |
| <a name="input_password"></a> [password](#input_password)                                                                | The password for the user.                                                                                                                                                                   | `string`       |          |   yes    |
| <a name="input_secret_recovery_window_days"></a> [secret_recovery_window_days](#input_secret_recovery_window_days)       | The number of days that Secrets Manager waits before deleting a secret.                                                                                                                      | `number`       | `0`      |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                            | Tags to use for created resources.                                                                                                                                                           | `map(string)`  | `{}`     |    no    |
| <a name="input_username"></a> [username](#input_username)                                                                | The username.                                                                                                                                                                                | `string`       |          |   yes    |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_arn"></a> [secret_arn](#output_secret_arn) | The ARN of the secret that was created. |
| <a name="output_secret_name"></a> [secret_name](#output_secret_name) | The name of the secret that was created. |
