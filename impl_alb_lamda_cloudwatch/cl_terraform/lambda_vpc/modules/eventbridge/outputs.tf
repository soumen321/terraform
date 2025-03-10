output "rule_arns" {
  description = "Map of EventBridge rule names to their ARNs"
  value = {
    for k, v in aws_cloudwatch_event_rule.rules : k => v.arn
  }
}