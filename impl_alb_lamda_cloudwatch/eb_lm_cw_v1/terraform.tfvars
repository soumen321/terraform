lambda_function_name = "my_lambda_function"
lambda_env_vars = {
  ENV = "production"
}

event_rule_name = "asg-event-rule"
asg_arn         = "arn:aws:autoscaling:us-east-1:992382689423:autoScalingGroup:facccc3c-3034-4bc1-9cbc-177b9445ff64:autoScalingGroupName/terraform-20250224011317372800000001"

alarm_name          = "asg-cpu-alarm"
comparison_operator = "GreaterThanThreshold"
evaluation_periods  = 2
metric_name         = "CPUUtilization"
namespace           = "AWS/EC2"
period              = 300
statistic           = "Average"
threshold           = 80
alarm_actions       = ["arn:aws:sns:us-east-1:992382689423:my-sns-topic"]
asg_name            = "terraform-20250224011317372800000001"