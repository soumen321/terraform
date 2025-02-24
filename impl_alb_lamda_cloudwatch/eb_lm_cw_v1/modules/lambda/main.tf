# Allow EventBridge to invoke the Lambda function
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.asg_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.event_rule_arn
}

# Create a zip file of the Python code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../python/"  # Correct path to the python directory
  output_path = "${path.module}/../../python/hello-python.zip"
}

# Lambda function
resource "aws_lambda_function" "asg_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "hello-python.lambda_handler"
  runtime       = "python3.8"
  filename      = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = var.lambda_env_vars
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_basic_execution]
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.lambda_function_name}_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach basic execution policy to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}