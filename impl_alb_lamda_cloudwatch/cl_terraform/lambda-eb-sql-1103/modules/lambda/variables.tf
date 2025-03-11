variable "lambda_functions" {
  description = "Map of Lambda functions and their configurations"
  type = map(object({
    filename     = string
    source_code_hash = string
    handler       = string
    runtime       = string
    role_arn     = string
    layers       = optional(list(string))
    # vpc_config = object({
    #   subnet_ids         = list(string)
    #   security_group_ids = list(string)
    # })
  }))
}