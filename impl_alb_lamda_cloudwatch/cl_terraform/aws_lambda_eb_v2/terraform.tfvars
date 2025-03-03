lambda_function_name = "engieit-bis-manage-cloudwatch-alarm_lab-demo"

eventbridge_rules = {
  clip_regenerate_alarm_demo = {
    name        = "clip-regenerate-alarm-demo"
    description = "Triggers Lambda when ASG names with prefixes pop-lab or clip-lab change"
    event_pattern = <<EOF
{
  "source": ["aws.autoscaling"],
  "detail-type": ["EC2 Instance Launch Successful", "EC2 Instance Terminate Successful"],
  "detail": {
    "AutoScalingGroupName": [{ "prefix": "pop-lab" }, { "prefix": "clip-lab" }]
  }
}
EOF
  },
  cloudwatch_status_rule_demo = {
    name        = "CLoudwatch_status_rule-demo"
    description = "Triggers Lambda when CloudWatch alarms with prefixes pop-lab eai or clip-lab-infra change state"
    event_pattern = <<EOF
{
  "source": ["aws.cloudwatch"],
  "detail-type": ["CloudWatch Alarm State Change"],
  "detail": {
    "alarmName": [{ "prefix": "pop-lab eai" }, { "prefix": "clip-lab-infra" }]
  }
}
EOF
  },
  clip_ssmlambda_trigger_rule_demo = {
    name        = "clip-ssmlambda-trigger-rule-demo"
    description = "Triggers Lambda when CloudWatch alarms with prefixes pop-lab-eai or clip-lab-infra change state"
    event_pattern = <<EOF
{
  "source": ["aws.cloudwatch"],
  "detail-type": ["CloudWatch Alarm State Change"],
  "detail": {
    "alarmName": [{ "prefix": "pop-lab-eai" }, { "prefix": "clip-lab-infra" }]
  }
}
EOF
  }
}

sqs_queue_name = "clip-service-now-trigger-demo.fifo"
fifo_queue = true
content_based_deduplication = true
sqs_batch_size = 10

s3_bucket_name = "managealarmv1"
s3_key_manage_cloudwatch = "manage_cloudwatch_alarm.zip"
s3_key_memory_usage = "memory_usage_detection.zip"
s3_key_service_now = "service_now_alarm.zip"