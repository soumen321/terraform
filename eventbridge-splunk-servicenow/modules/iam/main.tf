locals {
  lambda_ssm_policy        = file("${path.root}/permissions/lambda_ssm.json")
  lambda_ec2_policy       = file("${path.root}/permissions/lambda_ec2_network.json")
  lambda_cloudwatch_policy = file("${path.root}/permissions/lambda_cloudwatch.json")
  stepfunction_policy     = file("${path.root}/permissions/stepfunction.json")
  
  lambda_dynamodb_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = "arn:aws:dynamodb:*:*:table/*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ]
        Resource = var.dynamodb_kms_key_arn
      }
    ]
  })
}

# IAM role for SplunkCreateQuery Lambda
resource "aws_iam_role" "splunk_create_query" {
  name = "${var.project_name}-${var.environment}-splunk-create-query-role"

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

resource "aws_iam_role_policy" "splunk_create_query_permissions" {
  for_each = {
    ssm        = local.lambda_ssm_policy
    ec2        = local.lambda_ec2_policy
    dynamodb   = local.lambda_dynamodb_policy
    cloudwatch = local.lambda_cloudwatch_policy
  }

  name   = "${var.project_name}-${var.environment}-splunk-create-query-${each.key}"
  role   = aws_iam_role.splunk_create_query.id
  policy = each.value
}

# IAM role for SplunkQueryRunParse Lambda
resource "aws_iam_role" "splunk_query_run_parse" {
  name = "${var.project_name}-${var.environment}-splunk-query-run-parse-role"

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

resource "aws_iam_role_policy" "splunk_query_run_parse_permissions" {
  for_each = {
    ssm        = local.lambda_ssm_policy
    ec2        = local.lambda_ec2_policy
    dynamodb   = local.lambda_dynamodb_policy
    cloudwatch = local.lambda_cloudwatch_policy
  }

  name   = "${var.project_name}-${var.environment}-splunk-query-run-parse-${each.key}"
  role   = aws_iam_role.splunk_query_run_parse.id
  policy = each.value
}

# IAM role for ServiceNow Lambda
resource "aws_iam_role" "servicenow" {
  name = "${var.project_name}-${var.environment}-servicenow-role"

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

resource "aws_iam_role_policy" "servicenow_permissions" {
  for_each = {
    ssm        = local.lambda_ssm_policy
    ec2        = local.lambda_ec2_policy
    cloudwatch = local.lambda_cloudwatch_policy
  }

  name   = "${var.project_name}-${var.environment}-servicenow-${each.key}"
  role   = aws_iam_role.servicenow.id
  policy = each.value
}

# IAM role for Step Function
resource "aws_iam_role" "step_function" {
  name = "${var.project_name}-${var.environment}-step-function-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "step_function_permissions" {
  name   = "${var.project_name}-${var.environment}-step-function"
  role   = aws_iam_role.step_function.id
  policy = local.stepfunction_policy
}