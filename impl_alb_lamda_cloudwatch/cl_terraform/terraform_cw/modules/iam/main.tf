resource "aws_iam_role" "lambda_role" {
  for_each = var.lambda_functions

  name = "${each.key}-role"

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

  tags = {
    Environment = "demo"
    Terraform   = "true"
  }
}

# Lambda base policy
resource "aws_iam_policy" "lambda_policy" {
  for_each = var.lambda_functions

  name        = "${each.key}-policy"
  description = "Base IAM policy for Lambda function ${each.key}"
  policy      = file("${path.root}/permission/lambda_policy.json")
}

# Service-specific policies for Lambda
resource "aws_iam_policy" "lambda_autoscaling_policy" {
  for_each = var.lambda_functions

  name        = "${each.key}-autoscaling-policy"
  description = "AutoScaling policy for Lambda function ${each.key}"
  policy      = file("${path.root}/permission/autoscaling_policy.json")
}

resource "aws_iam_policy" "lambda_cloudwatch_policy" {
  for_each = var.lambda_functions

  name        = "${each.key}-cloudwatch-policy"
  description = "CloudWatch policy for Lambda function ${each.key}"
  policy      = file("${path.root}/permission/cloudwatch_policy.json")
}

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  for_each = var.lambda_functions

  name        = "${each.key}-dynamodb-policy"
  description = "DynamoDB policy for Lambda function ${each.key}"
  policy      = file("${path.root}/permission/dynamodb_policy.json")
}

resource "aws_iam_policy" "lambda_ec2_policy" {
  for_each = var.lambda_functions

  name        = "${each.key}-ec2-policy"
  description = "EC2 policy for Lambda function ${each.key}"
  policy      = file("${path.root}/permission/ec2_policy.json")
}

resource "aws_iam_policy" "lambda_elb_policy" {
  for_each = var.lambda_functions

  name        = "${each.key}-elb-policy"
  description = "ELB policy for Lambda function ${each.key}"
  policy      = file("${path.root}/permission/elb_policy.json")
}

resource "aws_iam_policy" "lambda_sns_policy" {
  for_each = var.lambda_functions

  name        = "${each.key}-sns-policy"
  description = "SNS policy for Lambda function ${each.key}"
  policy      = file("${path.root}/permission/sns_policy.json")
}

# Policy attachments for Lambda
resource "aws_iam_role_policy_attachment" "lambda_base_policy" {
  for_each = var.lambda_functions

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_policy[each.key].arn
}

resource "aws_iam_role_policy_attachment" "lambda_autoscaling_policy" {
  for_each = var.lambda_functions

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_autoscaling_policy[each.key].arn
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_policy" {
  for_each = var.lambda_functions

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_cloudwatch_policy[each.key].arn
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_policy" {
  for_each = var.lambda_functions

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy[each.key].arn
}

resource "aws_iam_role_policy_attachment" "lambda_ec2_policy" {
  for_each = var.lambda_functions

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_ec2_policy[each.key].arn
}

resource "aws_iam_role_policy_attachment" "lambda_elb_policy" {
  for_each = var.lambda_functions

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_elb_policy[each.key].arn
}

resource "aws_iam_role_policy_attachment" "lambda_sns_policy" {
  for_each = var.lambda_functions

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_sns_policy[each.key].arn
}

# EventBridge role and policies
resource "aws_iam_role" "eventbridge_role" {
  name = "eventbridge-role"

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

  tags = {
    Environment = "demo"
    Terraform   = "true"
  }
}

resource "aws_iam_policy" "eventbridge_policy" {
  name        = "eventbridge-policy"
  description = "IAM policy for EventBridge"
  policy      = file("${path.root}/permission/eventbridge_policy.json")
}

resource "aws_iam_role_policy_attachment" "eventbridge_policy" {
  role       = aws_iam_role.eventbridge_role.name
  policy_arn = aws_iam_policy.eventbridge_policy.arn
}

# SQS role and policies
resource "aws_iam_role" "sqs_role" {
  name = "sqs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sqs.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Environment = "demo"
    Terraform   = "true"
  }
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "sqs-policy"
  description = "IAM policy for SQS"
  policy      = file("${path.root}/permission/sqs_policy.json")
}

resource "aws_iam_role_policy_attachment" "sqs_policy" {
  role       = aws_iam_role.sqs_role.name
  policy_arn = aws_iam_policy.sqs_policy.arn
}