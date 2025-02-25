resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.eventbridge_arn
}

resource "aws_lambda_function" "this" {
  function_name = var.lambda_function_name
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  handler       = var.handler
  runtime       = var.runtime
  role          = var.role_arn

  environment {
    variables = {
      EVENT_TYPE = "Matched event"
    }
  }
}


