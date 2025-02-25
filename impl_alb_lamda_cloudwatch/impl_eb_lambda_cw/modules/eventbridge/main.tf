resource "aws_cloudwatch_event_rule" "asg_event_rule" {
  name        = var.eventbridge_name
  description = "EventBridge rule for ASG name prefixes"

  event_pattern = jsonencode({
    source      = ["aws.autoscaling"]
    detail-type = ["EC2 Instance Launch Successful", "EC2 Instance Terminate Successful"]
    detail = {
      AutoScalingGroupName = [
        for prefix in var.asg_name_prefix : {
          prefix = prefix
        }
      ]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.asg_event_rule.name
  target_id = "LambdaTarget"
  arn       = var.lambda_arn
}



# resource "aws_lambda_permission" "allow_eventbridge" {
#   statement_id  = "AllowExecutionFromEventBridge-${aws_cloudwatch_event_rule.asg_event_rule.id}"
#   action        = "lambda:InvokeFunction"
#   function_name = var.lambda_function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.asg_event_rule.arn
# }

output "eventbridge_arn" {
  value = aws_cloudwatch_event_rule.asg_event_rule.arn
}