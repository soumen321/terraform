variable "event_rule_name" {
  description = "Name of the EventBridge rule"
  type        = string
}

variable "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to trigger"
  type        = string
}