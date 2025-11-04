variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

variable "step_function_arn" {
  description = "ARN of the Step Function to trigger"
  type        = string
}