resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.lambda_exec_role_arn
  handler       = "index.handler"
  runtime       = "python3.9"  # Use a supported runtime

  # Fetch Lambda code from S3
  s3_bucket = var.s3_bucket_name
  s3_key    = var.s3_key_manage_cloudwatch

  environment {
    variables = {
      # Environment variables if any
    }
  }
}

resource "aws_lambda_function" "memory_usage_detection" {
  function_name = "engieit-bis-memory-usage-detection_lab-demo"
  role          = var.lambda_exec_role_arn
  handler       = "index.handler"
  runtime       = "python3.9"  # Use a supported runtime

  # Fetch Lambda code from S3
  s3_bucket = var.s3_bucket_name
  s3_key    = var.s3_key_memory_usage

  environment {
    variables = {
      # Environment variables if any
    }
  }
}

resource "aws_lambda_function" "service_now_alarm" {
  function_name = "engieit-bis-manage-serviceNow-alarm_lab-demo"
  role          = var.lambda_exec_role_arn
  handler       = "index.handler"
  runtime       = "python3.9"  # Use a supported runtime

  # Fetch Lambda code from S3
  s3_bucket = var.s3_bucket_name
  s3_key    = var.s3_key_service_now

  environment {
    variables = {
      # Environment variables if any
    }
  }
}

output "lambda_arn" {
  description = "The ARN of the main Lambda function"
  value       = aws_lambda_function.this.arn
}

output "memory_usage_detection_lambda_arn" {
  description = "The ARN of the memory usage detection Lambda function"
  value       = aws_lambda_function.memory_usage_detection.arn
}

output "service_now_alarm_lambda_arn" {
  description = "The ARN of the ServiceNow alarm Lambda function"
  value       = aws_lambda_function.service_now_alarm.arn
}