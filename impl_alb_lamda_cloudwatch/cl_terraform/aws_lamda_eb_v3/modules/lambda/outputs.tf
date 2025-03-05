output "manage_cloudwatch_alarm_lambda_arn" {
  description = "ARN of the manage CloudWatch alarm Lambda function"
  value       = aws_lambda_function.manage_cloudwatch_alarm.arn
}

output "memory_usage_detection_lambda_arn" {
  description = "ARN of the memory usage detection Lambda function"
  value       = aws_lambda_function.memory_usage_detection.arn
}

output "manage_servicenow_alarm_lambda_arn" {
  description = "ARN of the manage ServiceNow alarm Lambda function"
  value       = aws_lambda_function.manage_servicenow_alarm.arn
}