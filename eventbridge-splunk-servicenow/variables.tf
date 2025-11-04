variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
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

variable "dynamodb_kms_key_arn" {
  description = "ARN of existing KMS key for DynamoDB encryption"
  type        = string
}

