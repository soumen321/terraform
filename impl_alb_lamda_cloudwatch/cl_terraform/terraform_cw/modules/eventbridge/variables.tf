variable "eventbridge_rules" {
  description = "Map of EventBridge rules and their configurations"
  type = map(object({
    description = string
    pattern     = string
    targets     = list(string)
    role_arn    = string
    target_arn  = string
    input_transformer = optional(object({
      input_paths    = map(string)
      input_template = string
    }))
  }))
}