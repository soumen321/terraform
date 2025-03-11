aws_region = "us-east-1"

# VPC Configuration
# environment = "demo"
# vpc_cidr = "10.0.0.0/16"
# private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
# availability_zones = ["us-east-1a", "us-east-1b"]

# EventBridge rules
clip_regenerate_alarm_rule_name = "clip-regenerate-alarm-demo"
cloudwatch_status_rule_name = "CLoudwatch_status_rule-demo"
clip_ssmlamda_trigger_rule_name = "clip-ssmlamda-trigger-rule-demo"

# Event pattern prefixes
autoscaling_group_prefixes = ["pop-lab", "clip-lab"]
cloudwatch_status_alarm_prefixes = ["pop-lab eai", "clip-lab-infra"]
ssm_lambda_alarm_prefixes = ["pop-lab-eai", "clip-lab-infra"]

# Lambda functions
manage_cloudwatch_alarm_lambda_name = "engieit-bis-manage-cloudwatch-alarm_lab-demo"
memory_usage_detection_lambda_name = "engieit-bis-memory-usage-detection_lab-demo"
manage_servicenow_alarm_lambda_name = "engieit-bis-manage-serviceNow-alarm_lab-demo"

# Lambda layer
servicenow_layer_arn = ""

# S3 configuration
# s3_bucket = "managealarmv1"
# s3_key_manage_cloudwatch = "manage_cloudwatch_alarm.zip"
# s3_key_memory_usage = "memory_usage_detection.zip"
# s3_key_service_now = "service_now_alarm.zip"

# SQS queue
service_now_queue_name = "clip-service-now-trigger-demo.fifo"