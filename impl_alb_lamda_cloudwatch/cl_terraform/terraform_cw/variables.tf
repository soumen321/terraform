variable "aws_region" {
  description = "AWS region"
  type        = string
}

# EventBridge rules
variable "clip_regenerate_alarm_rule_name" {
  description = "Name of the clip-regenerate-alarm rule"
  type        = string
}

variable "cloudwatch_status_rule_name" {
  description = "Name of the CloudWatch status rule"
  type        = string
}

variable "clip_ssmlamda_trigger_rule_name" {
  description = "Name of the clip-ssmlamda-trigger rule"
  type        = string
}

# Event pattern prefixes
variable "autoscaling_group_prefixes" {
  description = "List of AutoScaling group name prefixes"
  type        = list(string)
}

variable "cloudwatch_status_alarm_prefixes" {
  description = "List of CloudWatch status alarm name prefixes"
  type        = list(string)
}

variable "ssm_lambda_alarm_prefixes" {
  description = "List of SSM Lambda alarm name prefixes"
  type        = list(string)
}

# Lambda functions
variable "manage_cloudwatch_alarm_lambda_name" {
  description = "Name of the manage CloudWatch alarm Lambda function"
  type        = string
}

variable "memory_usage_detection_lambda_name" {
  description = "Name of the memory usage detection Lambda function"
  type        = string
}

variable "manage_servicenow_alarm_lambda_name" {
  description = "Name of the manage ServiceNow alarm Lambda function"
  type        = string
}

# Lambda layer
variable "servicenow_layer_arn" {
  description = "ARN of the ServiceNow Lambda layer"
  type        = string
}

# S3 configuration
variable "s3_bucket" {
  description = "S3 bucket containing Lambda function code"
  type        = string
}

variable "s3_key_manage_cloudwatch" {
  description = "S3 key for manage cloudwatch alarm Lambda function"
  type        = string
}

variable "s3_key_memory_usage" {
  description = "S3 key for memory usage detection Lambda function"
  type        = string
}

variable "s3_key_service_now" {
  description = "S3 key for ServiceNow alarm Lambda function"
  type        = string
}

# SQS queue
variable "service_now_queue_name" {
  description = "Name of the ServiceNow trigger SQS queue"
  type        = string
}