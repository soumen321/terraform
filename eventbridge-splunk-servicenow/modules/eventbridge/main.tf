resource "aws_cloudwatch_event_rule" "execute_step_function" {
  name                = "${var.project_name}-${var.environment}-execute-step-function"
  description         = "Trigger Step Function every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "step_function" {
  rule      = aws_cloudwatch_event_rule.execute_step_function.name
  arn       = var.step_function_arn
  role_arn  = aws_iam_role.eventbridge_role.arn
  target_id = "StepFunctionTarget"

  # Empty input as the Step Function will start with the SplunkCreateQuery Lambda
  input = "{}"
}

# IAM role for EventBridge to invoke Step Function
resource "aws_iam_role" "eventbridge_role" {
  name = "${var.project_name}-${var.environment}-eventbridge-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "eventbridge_permissions" {
  name = "${var.project_name}-${var.environment}-eventbridge-policy"
  role = aws_iam_role.eventbridge_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "states:StartExecution"
        ]
        Resource = [var.step_function_arn]
      }
    ]
  })
}