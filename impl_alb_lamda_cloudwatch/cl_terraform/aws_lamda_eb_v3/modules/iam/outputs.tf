output "lambda_role_arn" {
  description = "ARN of the Lambda IAM role"
  value       = aws_iam_role.lambda_role.arn
}

output "eventbridge_role_arn" {
  description = "ARN of the EventBridge IAM role"
  value       = aws_iam_role.eventbridge_role.arn
}