resource "aws_cloudwatch_metric_alarm" "asg_alarm" {
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_actions       = var.alarm_actions

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}