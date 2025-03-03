variable "lambda_function_arn" {
  description = "The ARN of the main Lambda function"
  type        = string
}

variable "memory_usage_detection_lambda_arn" {
  description = "The ARN of the memory usage detection Lambda function"
  type        = string
}

variable "eventbridge_rules" {
  description = "A map of EventBridge rules to create"
  type = map(object({
    name        = string
    description = string
    event_pattern = string
  }))
}