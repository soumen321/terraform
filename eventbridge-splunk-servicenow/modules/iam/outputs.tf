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