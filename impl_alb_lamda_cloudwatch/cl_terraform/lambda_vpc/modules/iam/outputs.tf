output "lambda_role_arns" {
  description = "Map of Lambda function names to their role ARNs"
  value = {
    for k, v in aws_iam_role.lambda_role : k => v.arn
  }
}

output "eventbridge_role_arn" {
  description = "EventBridge role ARN"
  value       = aws_iam_role.eventbridge_role.arn
}

output "sqs_role_arn" {
  description = "SQS role ARN"
  value       = aws_iam_role.sqs_role.arn
}