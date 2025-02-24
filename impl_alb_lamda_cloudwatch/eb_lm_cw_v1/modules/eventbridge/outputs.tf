output "event_rule_arn" {
  value = aws_cloudwatch_event_rule.asg_event_rule.arn
}