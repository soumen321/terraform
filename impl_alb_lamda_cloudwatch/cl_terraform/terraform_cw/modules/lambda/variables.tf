variable "lambda_functions" {
  description = "Map of Lambda functions and their configurations"
  type = map(object({
    s3_bucket = string
    s3_key    = string
    handler   = string
    runtime   = string
    role_arn  = string
    layers    = optional(list(string))
  }))
}