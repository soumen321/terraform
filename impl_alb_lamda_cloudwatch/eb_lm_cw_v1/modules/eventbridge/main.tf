resource "aws_cloudwatch_event_rule" "asg_event_rule" {
  name        = var.event_rule_name
  description = "Trigger on ASG events"

  event_pattern = jsonencode({
    source      = ["aws.autoscaling"]
    detail-type = ["EC2 Instance Launch Successful", "EC2 Instance Terminate Successful"]
    resources   = [var.asg_arn]
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.asg_event_rule.name
  target_id = "LambdaTarget"
  arn       = var.lambda_function_arn
}