output "service_now_queue_url" {
  description = "URL of the ServiceNow SQS queue"
  value       = aws_sqs_queue.service_now_queue.id
}

output "service_now_queue_arn" {
  description = "ARN of the ServiceNow SQS queue"
  value       = aws_sqs_queue.service_now_queue.arn
}