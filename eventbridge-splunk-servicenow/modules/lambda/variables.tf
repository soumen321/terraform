variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

variable "splunk_create_query_role_arn" {
  description = "ARN of the IAM role for SplunkCreateQuery Lambda"
  type        = string
}

variable "splunk_query_run_parse_role_arn" {
  description = "ARN of the IAM role for SplunkQueryRunParse Lambda"
  type        = string
}

variable "servicenow_role_arn" {
  description = "ARN of the IAM role for ServiceNow Lambda"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for Lambda functions"
  type        = list(string)
}

variable "lambda_security_group_ids" {
  description = "List of existing security group IDs to attach to Lambda functions"
  type        = list(string)
}