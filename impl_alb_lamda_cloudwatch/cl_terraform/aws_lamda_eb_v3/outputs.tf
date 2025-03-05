output "manage_cloudwatch_alarm_lambda_arn" {
  description = "ARN of the manage CloudWatch alarm Lambda function"
  value       = module.lambda.manage_cloudwatch_alarm_lambda_arn
}

output "memory_usage_detection_lambda_arn" {
  description = "ARN of the memory usage detection Lambda function"
  value       = module.lambda.memory_usage_detection_lambda_arn
}

output "manage_servicenow_alarm_lambda_arn" {
  description = "ARN of the manage ServiceNow alarm Lambda function"
  value       = module.lambda.manage_servicenow_alarm_lambda_arn
}

output "service_now_queue_url" {
  description = "URL of the ServiceNow SQS queue"
  value       = module.sqs.service_now_queue_url
}

output "service_now_queue_arn" {
  description = "ARN of the ServiceNow SQS queue"
  value       = module.sqs.service_now_queue_arn
}

output "lambda_role_arn" {
  description = "ARN of the Lambda IAM role"
  value       = module.iam.lambda_role_arn
}

output "eventbridge_role_arn" {
  description = "ARN of the EventBridge IAM role"
  value       = module.iam.eventbridge_role_arn
}