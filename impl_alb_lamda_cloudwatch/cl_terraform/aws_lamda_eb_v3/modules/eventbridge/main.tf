resource "aws_cloudwatch_event_rule" "clip_regenerate_alarm_rule" {
  name        = var.clip_regenerate_alarm_rule_name
  description = "EventBridge rule for clip regenerate alarm"
  
  event_pattern = jsonencode({
    "source": ["aws.cloudwatch"],
    "detail-type": ["CloudWatch Alarm State Change"],
    "detail": {
      "AutoScalingGroupName": [for prefix in var.autoscaling_group_prefixes : { "prefix": prefix }]
    }
  })
}

resource "aws_cloudwatch_event_target" "clip_regenerate_alarm_target" {
  rule      = aws_cloudwatch_event_rule.clip_regenerate_alarm_rule.name
  target_id = "SendToLambda"
  arn       = var.manage_cloudwatch_alarm_lambda_arn
  role_arn  = var.eventbridge_role_arn
}

resource "aws_cloudwatch_event_rule" "cloudwatch_status_rule" {
  name        = var.cloudwatch_status_rule_name
  description = "EventBridge rule for CloudWatch status"
  
  event_pattern = jsonencode({
    "source": ["aws.cloudwatch"],
    "detail-type": ["CloudWatch Alarm State Change"],
    "detail": {
      "alarmName": [for prefix in var.cloudwatch_status_alarm_prefixes : { "prefix": prefix }]
    }
  })
}

resource "aws_cloudwatch_event_target" "cloudwatch_status_target" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_status_rule.name
  target_id = "SendToLambda"
  arn       = var.manage_cloudwatch_alarm_lambda_arn
  role_arn  = var.eventbridge_role_arn
}

resource "aws_cloudwatch_event_rule" "clip_ssmlamda_trigger_rule" {
  name        = var.clip_ssmlamda_trigger_rule_name
  description = "EventBridge rule for SSM Lambda trigger"
  
  event_pattern = jsonencode({
    "source": ["aws.cloudwatch"],
    "detail-type": ["CloudWatch Alarm State Change"],
    "detail": {
      "alarmName": [for prefix in var.ssm_lambda_alarm_prefixes : { "prefix": prefix }]
    }
  })
}

resource "aws_cloudwatch_event_target" "clip_ssmlamda_trigger_target" {
  rule      = aws_cloudwatch_event_rule.clip_ssmlamda_trigger_rule.name
  target_id = "SendToLambda"
  arn       = var.memory_usage_detection_lambda_arn
  role_arn  = var.eventbridge_role_arn
  
  input_transformer {
    input_paths = {
      "instanceid" = "$.detail.instance-id",
      "alarmname"  = "$.detail.alarmName",
      "metricname" = "$.detail.metricName",
      "statevalue" = "$.detail.state.value"
    }
    
    input_template = <<EOF
{
  "instanceId": <instanceid>,
  "alarmName": <alarmname>,
  "metricName": <metricname>,
  "stateValue": <statevalue>
}
EOF
  }
}