output "eventbridge_rule_arn" {
  description = "ARN of the EventBridge rule"
  value       = module.eventbridge.rule_arn
}

output "step_function_arn" {
  description = "ARN of the Step Function"
  value       = module.stepfunction.step_function_arn
}

output "lambda_arns" {
  description = "ARNs of the Lambda functions"
  value       = module.lambda.lambda_arns
}