variable "lambda_functions" {
  description = "Map of Lambda functions and their IAM role names"
  type = map(object({
    role_name = string
  }))
}

variable "subnet_ids" {
  description = "List of subnet IDs to attach Lambda functions to"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to Lambda functions"
  type        = list(string)
}