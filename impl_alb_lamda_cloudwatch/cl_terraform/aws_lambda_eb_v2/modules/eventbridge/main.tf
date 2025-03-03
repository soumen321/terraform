resource "aws_cloudwatch_event_rule" "this" {
  for_each = var.eventbridge_rules

  name        = each.value.name
  description = each.value.description
  event_pattern = each.value.event_pattern
}

resource "aws_cloudwatch_event_target" "this" {
  for_each = aws_cloudwatch_event_rule.this

  rule      = each.value.name
  target_id = "LambdaTarget"
  arn       = each.value.name == "clip-ssmlambda-trigger-rule-demo" ? var.memory_usage_detection_lambda_arn : var.lambda_function_arn

  # Input transformer for the new rule
  dynamic "input_transformer" {
    for_each = each.value.name == "clip-ssmlambda-trigger-rule-demo" ? [1] : []
    content {
      input_paths = {
        instanceid  = "$.detail.instance-id"
        alarmname   = "$.detail.alarmName"
        metricname  = "$.detail.metricName"
        statevalue  = "$.detail.state.value"
      }
      input_template = <<EOF
{
  "instanceid": <instanceid>,
  "alarmname": <alarmname>,
  "metricname": <metricname>,
  "statevalue": <statevalue>
}
EOF
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  for_each = aws_cloudwatch_event_rule.this

  statement_id  = "AllowExecutionFromCloudWatch-${each.value.name}"  # Unique statement_id
  action        = "lambda:InvokeFunction"
  function_name = each.value.name == "clip-ssmlambda-trigger-rule-demo" ? var.memory_usage_detection_lambda_arn : var.lambda_function_arn
  principal     = "events.amazonaws.com"
  source_arn    = each.value.arn
}

output "eventbridge_rule_arns" {
  value = { for k, v in aws_cloudwatch_event_rule.this : k => v.arn }
}