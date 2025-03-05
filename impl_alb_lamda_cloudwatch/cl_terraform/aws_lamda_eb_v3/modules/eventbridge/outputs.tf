output "clip_regenerate_alarm_rule_arn" {
  description = "ARN of the clip-regenerate-alarm EventBridge rule"
  value       = aws_cloudwatch_event_rule.clip_regenerate_alarm_rule.arn
}

output "cloudwatch_status_rule_arn" {
  description = "ARN of the CloudWatch status EventBridge rule"
  value       = aws_cloudwatch_event_rule.cloudwatch_status_rule.arn
}

output "clip_ssmlamda_trigger_rule_arn" {
  description = "ARN of the clip-ssmlamda-trigger EventBridge rule"
  value       = aws_cloudwatch_event_rule.clip_ssmlamda_trigger_rule.arn
}