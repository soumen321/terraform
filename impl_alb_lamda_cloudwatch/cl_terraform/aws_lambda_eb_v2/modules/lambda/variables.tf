variable "function_name" {
  description = "The name of the main Lambda function"
  type        = string
}

variable "lambda_exec_role_arn" {
  description = "The ARN of the Lambda execution role"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket containing the Lambda code"
  type        = string
}

variable "s3_key_manage_cloudwatch" {
  description = "The S3 key for the manage-cloudwatch Lambda code"
  type        = string
}

variable "s3_key_memory_usage" {
  description = "The S3 key for the memory-usage-detection Lambda code"
  type        = string
}

variable "s3_key_service_now" {
  description = "The S3 key for the service-now-alarm Lambda code"
  type        = string
}