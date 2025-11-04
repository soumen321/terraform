output "lambda_arns" {
  description = "ARNs of all Lambda functions"
  value = {
    splunk_create_query    = aws_lambda_function.splunk_create_query.arn
    splunk_query_run_parse = aws_lambda_function.splunk_query_run_parse.arn
    servicenow            = aws_lambda_function.servicenow.arn
  }
}