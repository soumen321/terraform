variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "eventbridge_name" {
  description = "Name of the EventBridge rule"
  type        = string
}

variable "asg_name_prefix" {
  description = "Prefix of the ASG names to trigger the EventBridge rule"
  type        = list(string)
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket where the Lambda code is stored"
  type        = string
}

variable "s3_key" {
  description = "S3 key for the Lambda code zip file"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
}