variable "queues" {
  description = "Map of SQS queues and their configurations"
  type = map(object({
    fifo_queue                  = bool
    content_based_deduplication = bool
    target_lambda              = string
    role_arn                   = string
  }))
}

variable "lambda_function_arns" {
  description = "Map of Lambda function names to their ARNs"
  type        = map(string)
}