variable "lambda_function_name" {
  description = "The name of the main Lambda function"
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

variable "sqs_queue_name" {
  description = "The name of the SQS queue"
  type        = string
}

variable "fifo_queue" {
  description = "Whether the queue is a FIFO queue"
  type        = bool
  default     = true
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO queues"
  type        = bool
  default     = true
}

variable "sqs_batch_size" {
  description = "The maximum number of records to retrieve from the SQS queue in a single batch"
  type        = number
  default     = 10
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