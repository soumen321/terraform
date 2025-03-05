output "function_arns" {
  description = "Map of Lambda function names to their ARNs"
  value = {
    for k, v in aws_lambda_function.functions : k => v.arn
  }
}