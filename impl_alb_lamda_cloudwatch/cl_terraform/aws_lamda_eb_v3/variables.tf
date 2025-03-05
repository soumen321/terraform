variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# EventBridge variables
variable "clip_regenerate_alarm_rule_name" {
  description = "Name of the clip-regenerate-alarm EventBridge rule"
  type        = string
  default     = "clip-regenerate-alarm-demo"
}

variable "cloudwatch_status_rule_name" {
  description = "Name of the CloudWatch status EventBridge rule"
  type        = string
  default     = "CLoudwatch_status_rule-demo"
}

variable "clip_ssmlamda_trigger_rule_name" {
  description = "Name of the clip-ssmlamda-trigger EventBridge rule"
  type        = string
  default     = "clip-ssmlamda-trigger-rule-demo"
}

# Event pattern variables
variable "autoscaling_group_prefixes" {
  description = "List of AutoScalingGroup name prefixes for clip-regenerate-alarm"
  type        = list(string)
  default     = ["pop-lab", "clip-lab"]
}

variable "cloudwatch_status_alarm_prefixes" {
  description = "List of alarm name prefixes for CloudWatch status rule"
  type        = list(string)
  default     = ["pop-lab eai", "clip-lab-infra"]
}

variable "ssm_lambda_alarm_prefixes" {
  description = "List of alarm name prefixes for SSM Lambda trigger rule"
  type        = list(string)
  default     = ["pop-lab-eai", "clip-lab-infra"]
}

# Lambda variables
variable "manage_cloudwatch_alarm_lambda_name" {
  description = "Name of the manage CloudWatch alarm Lambda function"
  type        = string
  default     = "engieit-bis-manage-cloudwatch-alarm_lab-demo"
}

variable "memory_usage_detection_lambda_name" {
  description = "Name of the memory usage detection Lambda function"
  type        = string
  default     = "engieit-bis-memory-usage-detection_lab-demo"
}

variable "manage_servicenow_alarm_lambda_name" {
  description = "Name of the manage ServiceNow alarm Lambda function"
  type        = string
  default     = "engieit-bis-manage-serviceNow-alarm_lab-demo"
}

# S3 variables
variable "s3_bucket" {
  description = "S3 bucket containing Lambda code"
  type        = string
  default     = "managealarmmvdemo"
}

variable "s3_key_manage_cloudwatch" {
  description = "S3 key for manage CloudWatch alarm Lambda code"
  type        = string
  default     = "manage_cloudwatch_alarm.zip"
}

variable "s3_key_memory_usage" {
  description = "S3 key for memory usage detection Lambda code"
  type        = string
  default     = "memory_usage_detection.zip"
}

variable "s3_key_service_now" {
  description = "S3 key for ServiceNow alarm Lambda code"
  type        = string
  default     = "service_now_alarm.zip"
}

# SQS variables
variable "service_now_queue_name" {
  description = "Name of the ServiceNow SQS queue"
  type        = string
  default     = "clip-service-now-trigger-demo.fifo"
}

# IAM variables
variable "lambda_policy_path" {
  description = "Path to the Lambda IAM policy JSON file"
  type        = string
  default     = "./permission/lambda_policy.json"
}

variable "eventbridge_policy_path" {
  description = "Path to the EventBridge IAM policy JSON file"
  type        = string
  default     = "./permission/eventbridge_policy.json"
}