output "lambda_arns" {
  description = "The ARNs of the Lambda functions"
  value = {
    main_lambda_arn            = module.lambda.lambda_arn
    memory_usage_detection_arn = module.lambda.memory_usage_detection_lambda_arn
    service_now_alarm_arn      = module.lambda.service_now_alarm_lambda_arn
  }
}

output "eventbridge_rule_arns" {
  description = "The ARNs of the EventBridge rules"
  value       = module.eventbridge.eventbridge_rule_arns
}

output "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.sqs.sqs_queue_arn
}