resource "aws_cloudwatch_event_rule" "rules" {
  for_each = var.eventbridge_rules

  name        = each.key
  description = each.value.description
  event_pattern = each.value.pattern

  tags = {
    Environment = "demo"
    Terraform   = "true"
  }
}

resource "aws_cloudwatch_event_target" "targets" {
  for_each = var.eventbridge_rules

  rule      = aws_cloudwatch_event_rule.rules[each.key].name
  target_id = "Lambda"
  arn       = each.value.target_arn
  role_arn  = each.value.role_arn

  dynamic "input_transformer" {
    for_each = each.value.input_transformer != null ? [each.value.input_transformer] : []
    
    content {
      input_paths    = input_transformer.value.input_paths
      input_template = input_transformer.value.input_template
    }
  }
}