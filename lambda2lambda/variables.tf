variable "lambda_a_name" {
  description = "Name for Lambda A"
  type        = string
  default     = "lambda-a"
}

variable "lambda_b_name" {
  description = "Name for Lambda B"
  type        = string
  default     = "lambda-b"
}

resource "aws_iam_policy" "invoke_lambda_b" {
  name        = "invoke-lambda-b"
  description = "Allow Lambda A to invoke Lambda B"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "lambda:InvokeFunction"
        Resource = module.lambda_b.lambda_function_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_a_invoke_b" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.invoke_lambda_b.arn
} 