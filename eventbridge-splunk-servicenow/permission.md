################################################################################
# Load Permission Policy Files
################################################################################

locals {
  lambda_ssm_policy        = file("${path.root}/permissions/lambda_ssm.json")
  lambda_ec2_policy       = file("${path.root}/permissions/lambda_ec2_network.json")
  lambda_cloudwatch_policy = file("${path.root}/permissions/lambda_cloudwatch.json")
  stepfunction_policy     = file("${path.root}/permissions/stepfunction.json")

 
  
  # Load DynamoDB policy template
  lambda_dynamodb_policy_template = jsondecode(file("${path.root}/permissions/lambda_dynamodb.json"))
}

################################################################################
# Generate DynamoDB Policies with Specific Table ARNs
################################################################################

locals {
  generate_dynamodb_policy = {
    table_1_only = jsonencode(merge(
      local.lambda_dynamodb_policy_template,
      {
        Statement = [
          merge(
            local.lambda_dynamodb_policy_template.Statement[0],
            {
              Resource = [var.dynamodb_table_1_arn]
            }
          ),
          merge(
            local.lambda_dynamodb_policy_template.Statement[1],
            {
              Resource = var.dynamodb_kms_key_arn
            }
          )
        ]
      }
    ))
    table_1_and_2 = jsonencode(merge(
      local.lambda_dynamodb_policy_template,
      {
        Statement = [
          merge(
            local.lambda_dynamodb_policy_template.Statement[0],
            {
              Resource = [var.dynamodb_table_1_arn, var.dynamodb_table_2_arn]
            }
          ),
          merge(
            local.lambda_dynamodb_policy_template.Statement[1],
            {
              Resource = var.dynamodb_kms_key_arn
            }
          )
        ]
      }
    ))
  }
}


################################################################################
# Generate CloudWatch Policies with Individual Lambda Log Group ARNs
################################################################################

locals {
  generate_cloudwatch_policy = {
    splunk_create_query = jsonencode(merge(
      local.lambda_cloudwatch_policy_template,
      {
        Statement = [
          merge(
            local.lambda_cloudwatch_policy_template.Statement[0],
            {
              Resource = [
                "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.project_name}-${var.environment}-${var.lambda_function_generate_splunk_query_name}:*"
              ]
            }
          )
        ]
      }
    ))
    splunk_query_run_parse = jsonencode(merge(
      local.lambda_cloudwatch_policy_template,
      {
        Statement = [
          merge(
            local.lambda_cloudwatch_policy_template.Statement[0],
            {
              Resource = [
                "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.project_name}-${var.environment}-${var.lambda_function_run_splunk_query_parse_name}:*"
              ]
            }
          )
        ]
      }
    ))
    servicenow = jsonencode(merge(
      local.lambda_cloudwatch_policy_template,
      {
        Statement = [
          merge(
            local.lambda_cloudwatch_policy_template.Statement[0],
            {
              Resource = [
                "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.project_name}-${var.environment}-${var.lambda_function_create_servicenow_ticket_name}:*"
              ]
            }
          )
        ]
      }
    ))
  }
}



################################################################################
# Combined IAM Policies Map for All Lambda Functions
################################################################################

locals {
  lambda_policies = {
    splunk_create_query = {
      ssm        = local.lambda_ssm_policy
      ec2        = local.lambda_ec2_policy
      cloudwatch = local.lambda_cloudwatch_policy
    }
    splunk_query_run_parse = {
      ssm        = local.lambda_ssm_policy
      ec2        = local.lambda_ec2_policy
      cloudwatch = local.lambda_cloudwatch_policy
    }
    servicenow = {
      ssm        = local.lambda_ssm_policy
      ec2        = local.lambda_ec2_policy
      cloudwatch = local.lambda_cloudwatch_policy
    }
  }
}

################################################################################
# IAM Role for SplunkCreateQuery Lambda
################################################################################

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
  for_each = local.lambda_policies.splunk_create_query

  name   = "${var.project_name}-${var.environment}-splunk-create-query-${each.key}"
  role   = aws_iam_role.splunk_create_query.id
  policy = each.value
}

################################################################################
# IAM Role for SplunkQueryRunParse Lambda
################################################################################

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
  for_each = local.lambda_policies.splunk_query_run_parse

  name   = "${var.project_name}-${var.environment}-splunk-query-run-parse-${each.key}"
  role   = aws_iam_role.splunk_query_run_parse.id
  policy = each.value
}

################################################################################
# IAM Role for ServiceNow Lambda
################################################################################

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
  for_each = local.lambda_policies.servicenow

  name   = "${var.project_name}-${var.environment}-servicenow-${each.key}"
  role   = aws_iam_role.servicenow.id
  policy = each.value
}

################################################################################
# DynamoDB Policies for Lambda Functions (SplunkCreateQuery and ServiceNow)
################################################################################

resource "aws_iam_role_policy" "lambda_dynamodb_policies" {
  for_each = {
    splunk_create_query = {
      role   = aws_iam_role.splunk_create_query.id
      policy = local.generate_dynamodb_policy.table_1_only
    }
    servicenow = {
      role   = aws_iam_role.servicenow.id
      policy = local.generate_dynamodb_policy.table_1_and_2
    }
  }

  name   = "${var.project_name}-${var.environment}-${each.key}-dynamodb"
  role   = each.value.role
  policy = each.value.policy
}

################################################################################
# IAM Role for Step Function
################################################################################

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
