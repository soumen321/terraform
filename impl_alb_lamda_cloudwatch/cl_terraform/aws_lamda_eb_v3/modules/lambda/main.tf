resource "aws_lambda_function" "manage_cloudwatch_alarm" {
  function_name = var.manage_cloudwatch_alarm_lambda_name
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.9"
  timeout       = 60
  memory_size   = 128
  
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key_manage_cloudwatch
  
  environment {
    variables = {
      ENVIRONMENT = "demo"
    }
  }
}

resource "aws_lambda_permission" "allow_eventbridge_to_call_manage_cloudwatch_alarm_regenerate" {
  statement_id  = "AllowExecutionFromEventBridgeRegenerate"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.manage_cloudwatch_alarm.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.clip_regenerate_alarm_rule_arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_call_manage_cloudwatch_alarm_status" {
  statement_id  = "AllowExecutionFromEventBridgeStatus"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.manage_cloudwatch_alarm.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_status_rule_arn
}

resource "aws_lambda_function" "memory_usage_detection" {
  function_name = var.memory_usage_detection_lambda_name
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.9"
  timeout       = 60
  memory_size   = 128
  
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key_memory_usage
  
  environment {
    variables = {
      ENVIRONMENT = "demo"
    }
  }
}

resource "aws_lambda_permission" "allow_eventbridge_to_call_memory_usage_detection" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.memory_usage_detection.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.clip_ssmlamda_trigger_rule_arn
}

resource "aws_lambda_function" "manage_servicenow_alarm" {
  function_name = var.manage_servicenow_alarm_lambda_name
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.9"
  timeout       = 60
  memory_size   = 128
  
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key_service_now
  
  environment {
    variables = {
      ENVIRONMENT = "demo"
    }
  }
}

resource "aws_lambda_permission" "allow_sqs_to_call_manage_servicenow_alarm" {
  statement_id  = "AllowExecutionFromSQS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.manage_servicenow_alarm.function_name
  principal     = "sqs.amazonaws.com"
  source_arn    = var.service_now_queue_arn
}