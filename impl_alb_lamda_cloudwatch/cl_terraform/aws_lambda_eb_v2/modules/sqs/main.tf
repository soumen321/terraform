resource "aws_sqs_queue" "this" {
  name                        = var.sqs_queue_name
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication
}

resource "aws_lambda_event_source_mapping" "this" {
  event_source_arn = aws_sqs_queue.this.arn
  function_name    = var.service_now_alarm_lambda_arn  # Target the ServiceNow alarm Lambda function
  batch_size       = var.batch_size
  enabled          = true
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.this.arn
}