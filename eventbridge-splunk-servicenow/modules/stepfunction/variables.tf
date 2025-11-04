variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role for Step Function"
  type        = string
}

variable "lambda_arns" {
  description = "Map of Lambda ARNs"
  type = object({
    splunk_create_query    = string
    splunk_query_run_parse = string
    servicenow            = string
  })
}