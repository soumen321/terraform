resource "aws_sqs_queue" "queues" {
  for_each = var.queues

  name                        = "${each.key}.fifo"
  fifo_queue                  = each.value.fifo_queue
  content_based_deduplication = each.value.content_based_deduplication

  tags = {
    Environment = "demo"
    Terraform   = "true"
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  for_each = var.queues

  event_source_arn = aws_sqs_queue.queues[each.key].arn
  function_name    = each.value.target_lambda
  enabled          = true
  batch_size       = 1
}