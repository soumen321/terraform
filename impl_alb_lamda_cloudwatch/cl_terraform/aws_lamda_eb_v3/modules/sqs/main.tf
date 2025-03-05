resource "aws_sqs_queue" "service_now_queue" {
  name                        = var.service_now_queue_name
  fifo_queue                  = true
  content_based_deduplication = true
  visibility_timeout_seconds  = 300
  message_retention_seconds   = 86400  # 1 day
  max_message_size            = 262144 # 256 KB
  delay_seconds               = 0
}

resource "aws_lambda_event_source_mapping" "sqs_lambda_mapping" {
  event_source_arn = aws_sqs_queue.service_now_queue.arn
  function_name    = var.manage_servicenow_alarm_lambda_arn
  batch_size       = 10
  enabled          = true
}