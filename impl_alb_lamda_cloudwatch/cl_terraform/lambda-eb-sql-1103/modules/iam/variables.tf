variable "lambda_functions" {
  description = "Map of Lambda functions and their configurations"
  type = map(object({
    filename = string
    handler  = string
    runtime  = string
  }))
}