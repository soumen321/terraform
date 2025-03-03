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

variable "service_now_alarm_lambda_arn" {
  description = "The ARN of the ServiceNow alarm Lambda function"
  type        = string
}

variable "batch_size" {
  description = "The maximum number of records to retrieve from the SQS queue in a single batch"
  type        = number
  default     = 10
}