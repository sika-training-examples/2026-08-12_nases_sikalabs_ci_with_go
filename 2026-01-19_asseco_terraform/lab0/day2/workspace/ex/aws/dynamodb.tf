module "pets_dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "5.5.0"

  name                        = "asseco-example-dynamodb-pets"
  hash_key                    = "id"
  range_key                   = "name"
  table_class                 = "STANDARD"
  deletion_protection_enabled = false

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "name"
      type = "S"
    }
  ]

  on_demand_throughput = {
    max_read_request_units  = 1
    max_write_request_units = 1
  }
}

module "pets_dynamodb_table_full_access_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.0"

  name = "asseco-example-dynamodb-pets-full-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:DescribeTable"
        ]
        Resource = [
          module.pets_dynamodb_table.dynamodb_table_arn
        ]
      }
    ]
  })
}

module "pets_dynamodb_table_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "6.3.0"

  name              = "asseco-example-dynamodb-pets-user"
  create_access_key = true

  policies = {
    pets_dynamodb_table_full_access_policy = module.pets_dynamodb_table_full_access_policy.arn
  }
}

output "dynamodb_user_access_key" {
  value = module.pets_dynamodb_table_user.access_key_id
}

output "dynamodb_user_secret_key" {
  value     = module.pets_dynamodb_table_user.access_key_secret
  sensitive = true
}
