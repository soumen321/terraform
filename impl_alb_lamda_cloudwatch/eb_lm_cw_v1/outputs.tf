output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}

output "eventbridge_rule_arn" {
  value = module.eventbridge.event_rule_arn
}

output "cloudwatch_alarm_arn" {
  value = module.cloudwatch_alarm.alarm_arn
}