variable "clip_regenerate_alarm_rule_name" {
  description = "Name of the clip-regenerate-alarm EventBridge rule"
  type        = string
}

variable "cloudwatch_status_rule_name" {
  description = "Name of the CloudWatch status EventBridge rule"
  type        = string
}

variable "clip_ssmlamda_trigger_rule_name" {
  description = "Name of the clip-ssmlamda-trigger EventBridge rule"
  type        = string
}

variable "manage_cloudwatch_alarm_lambda_arn" {
  description = "ARN of the manage CloudWatch alarm Lambda function"
  type        = string
}

variable "memory_usage_detection_lambda_arn" {
  description = "ARN of the memory usage detection Lambda function"
  type        = string
}

variable "eventbridge_role_arn" {
  description = "ARN of the EventBridge IAM role"
  type        = string
}

variable "autoscaling_group_prefixes" {
  description = "List of AutoScalingGroup name prefixes for clip-regenerate-alarm"
  type        = list(string)
}

variable "cloudwatch_status_alarm_prefixes" {
  description = "List of alarm name prefixes for CloudWatch status rule"
  type        = list(string)
}

variable "ssm_lambda_alarm_prefixes" {
  description = "List of alarm name prefixes for SSM Lambda trigger rule"
  type        = list(string)
}