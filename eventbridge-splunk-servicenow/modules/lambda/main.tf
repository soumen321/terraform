# SplunkCreateQuery Lambda
resource "aws_lambda_function" "splunk_create_query" {
  filename         = data.archive_file.splunk_create_query.output_path
  function_name    = "${var.project_name}-${var.environment}-splunk-create-query"
  role            = var.splunk_create_query_role_arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.9"
  timeout         = 300

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = var.lambda_security_group_ids
  }

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

data "archive_file" "splunk_create_query" {
  type        = "zip"
  source_dir  = "${path.root}/src/splunk_create_query"
  output_path = "${path.module}/splunk_create_query.zip"
}

# SplunkQueryRunParse Lambda
resource "aws_lambda_function" "splunk_query_run_parse" {
  filename         = data.archive_file.splunk_query_run_parse.output_path
  function_name    = "${var.project_name}-${var.environment}-splunk-query-run-parse"
  role            = var.splunk_query_run_parse_role_arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.9"
  timeout         = 300

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

data "archive_file" "splunk_query_run_parse" {
  type        = "zip"
  source_dir  = "${path.root}/src/splunk_query_run_parse"
  output_path = "${path.module}/splunk_query_run_parse.zip"
}

# ServiceNow Lambda
resource "aws_lambda_function" "servicenow" {
  filename         = data.archive_file.servicenow.output_path
  function_name    = "${var.project_name}-${var.environment}-servicenow"
  role            = var.servicenow_role_arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.9"
  timeout         = 300

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

data "archive_file" "servicenow" {
  type        = "zip"
  source_dir  = "${path.root}/src/servicenow"
  output_path = "${path.module}/servicenow.zip"
}