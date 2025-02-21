# output "dynamodb_table_names" {
#   value = { for k, v in module.dynamodb : k => v.dynamodb_table_name }
# }

# output "dynamodb_table_arns" {
#   value = { for k, v in module.dynamodb : k => v.dynamodb_table_arn }
# }