variable "lambda_function_arn" {
  description = "The ARN of the main Lambda function"
  type        = string
}

variable "memory_usage_detection_lambda_arn" {
  description = "The ARN of the memory usage detection Lambda function"
  type        = string
}

variable "service_now_alarm_lambda_arn" {
  description = "The ARN of the ServiceNow alarm Lambda function"
  type        = string
}

variable "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  type        = string
}