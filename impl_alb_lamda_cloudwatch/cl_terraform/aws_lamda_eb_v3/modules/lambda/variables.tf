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

variable "lambda_role_arn" {
  description = "ARN of the Lambda IAM role"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket containing Lambda code"
  type        = string
}

variable "s3_key_manage_cloudwatch" {
  description = "S3 key for manage CloudWatch alarm Lambda code"
  type        = string
}

variable "s3_key_memory_usage" {
  description = "S3 key for memory usage detection Lambda code"
  type        = string
}

variable "s3_key_service_now" {
  description = "S3 key for ServiceNow alarm Lambda code"
  type        = string
}

variable "clip_regenerate_alarm_rule_arn" {
  description = "ARN of the clip-regenerate-alarm EventBridge rule"
  type        = string
}

variable "cloudwatch_status_rule_arn" {
  description = "ARN of the CloudWatch status EventBridge rule"
  type        = string
}

variable "clip_ssmlamda_trigger_rule_arn" {
  description = "ARN of the clip-ssmlamda-trigger EventBridge rule"
  type        = string
}

variable "service_now_queue_arn" {
  description = "ARN of the ServiceNow SQS queue"
  type        = string
}