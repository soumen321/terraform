variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

variable "dynamodb_kms_key_arn" {
  description = "ARN of the KMS key for DynamoDB encryption"
  type        = string
}