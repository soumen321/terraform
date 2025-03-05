resource "aws_lambda_function" "functions" {
  for_each = var.lambda_functions

  function_name = each.key
  s3_bucket     = each.value.s3_bucket
  s3_key        = each.value.s3_key
  handler       = each.value.handler
  runtime       = each.value.runtime
  role          = each.value.role_arn
  layers        = each.value.layers

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