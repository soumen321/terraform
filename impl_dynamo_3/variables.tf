variable "tables" {
  description = "A map of DynamoDB table configurations"
  type = map(object({
    table_name   = string
    config_file  = string
    item_name    = string
    item_id      = number
    data_type    = string
  }))
}

variable "region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}