variable "eventbridge_name" {
  description = "Name of the EventBridge rule"
  type        = string
}

variable "asg_name_prefix" {
  description = "Prefix of the ASG names to trigger the EventBridge rule"
  type        = list(string)
}

variable "lambda_arn" {
  description = "ARN of the Lambda function to be triggered"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}