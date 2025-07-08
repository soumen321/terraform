variable "filename" {}
variable "function_name" {}
variable "role_arn" {}
variable "handler" {}
variable "runtime" {}
variable "environment_variables" {
  type    = map(string)
  default = {}
} 