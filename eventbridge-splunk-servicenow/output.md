output "splunk_create_query_role_arn" {
  description = "ARN of the SplunkCreateQuery Lambda role"
  value       = aws_iam_role.splunk_create_query.arn
}

output "splunk_query_run_parse_role_arn" {
  description = "ARN of the SplunkQueryRunParse Lambda role"
  value       = aws_iam_role.splunk_query_run_parse.arn
}

output "servicenow_role_arn" {
  description = "ARN of the ServiceNow Lambda role"
  value       = aws_iam_role.servicenow.arn
}

output "step_function_role_arn" {
  description = "ARN of the Step Function role"
  value       = aws_iam_role.step_function.arn
}

output "step_function_policy_id" {
  description = "ID of the Step Function inline policy (aws_iam_role_policy)"
  value       = aws_iam_role_policy.step_function_permissions.id
}

output "lambda_role_arns" {
  description = "Map of Lambda role ARNs"
  value = {
    splunk_create_query    = aws_iam_role.splunk_create_query.arn
    splunk_query_run_parse = aws_iam_role.splunk_query_run_parse.arn
    servicenow             = aws_iam_role.servicenow.arn
  }
}

output "lambda_role_names" {
  description = "Map of Lambda role names"
  value = {
    splunk_create_query    = aws_iam_role.splunk_create_query.name
    splunk_query_run_parse = aws_iam_role.splunk_query_run_parse.name
    servicenow             = aws_iam_role.servicenow.name
  }
}

output "lambda_ec2_policy_arns" {
  description = "Map of EC2 inline policy IDs attached to each Lambda role"
  value = {
    splunk_create_query    = aws_iam_role_policy.splunk_create_query_permissions["ec2"].id
    splunk_query_run_parse = aws_iam_role_policy.splunk_query_run_parse_permissions["ec2"].id
    servicenow             = aws_iam_role_policy.servicenow_permissions["ec2"].id
  }
}

output "lambda_cloudwatch_policy_arns" {
  description = "Map of CloudWatch inline policy IDs attached to each Lambda role"
  value = {
    splunk_create_query    = aws_iam_role_policy.splunk_create_query_permissions["cloudwatch"].id
    splunk_query_run_parse = aws_iam_role_policy.splunk_query_run_parse_permissions["cloudwatch"].id
    servicenow             = aws_iam_role_policy.servicenow_permissions["cloudwatch"].id
  }
}

output "lambda_dynamodb_policy_arns" {
  description = "Map of DynamoDB inline policy IDs (where applicable)"
  value = {
    splunk_create_query = aws_iam_role_policy.lambda_dynamodb_policies["splunk_create_query"].id
    servicenow          = aws_iam_role_policy.lambda_dynamodb_policies["servicenow"].id
  }
}

output "lambda_ssm_policy_arns" {
  description = "Map of SSM inline policy IDs attached to each Lambda role"
  value = {
    splunk_create_query    = aws_iam_role_policy.splunk_create_query_permissions["ssm"].id
    splunk_query_run_parse = aws_iam_role_policy.splunk_query_run_parse_permissions["ssm"].id
    servicenow             = aws_iam_role_policy.servicenow_permissions["ssm"].id
  }
}
