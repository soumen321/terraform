resource "aws_lambda_function" "functions" {
  for_each = var.lambda_functions

  function_name = each.key
  s3_bucket     = each.value.s3_bucket
  s3_key        = each.value.s3_key
  handler       = each.value.handler
  runtime       = each.value.runtime
  role          = each.value.role_arn
  layers        = each.value.layers

  vpc_config {
    subnet_ids         = each.value.vpc_config.subnet_ids
    security_group_ids = each.value.vpc_config.security_group_ids
  }

  environment {
    variables = {
      ENVIRONMENT = "demo"
    }
  }

  tags = {
    Environment = "demo"
    Terraform   = "true"
  }
}