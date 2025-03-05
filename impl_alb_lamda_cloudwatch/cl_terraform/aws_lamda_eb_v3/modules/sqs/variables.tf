variable "service_now_queue_name" {
  description = "Name of the ServiceNow SQS queue"
  type        = string
}

variable "manage_servicenow_alarm_lambda_arn" {
  description = "ARN of the manage ServiceNow alarm Lambda function"
  type        = string
}