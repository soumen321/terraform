output "rule_arn" {
  description = "ARN of the EventBridge rule"
  value       = aws_cloudwatch_event_rule.execute_step_function.arn
}

output "eventbridge_role_arn" {
  description = "ARN of the EventBridge IAM role"
  value       = aws_iam_role.eventbridge_role.arn
}