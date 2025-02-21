resource "aws_dynamodb_table" "default_cloudwatch_alarms" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = var.range_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  attribute {
    name = var.range_key
    type = "N"
  }

  tags = var.tags
}

resource "aws_dynamodb_table_item" "alarm_config_item" {
  table_name = aws_dynamodb_table.default_cloudwatch_alarms.name
  hash_key   = aws_dynamodb_table.default_cloudwatch_alarms.hash_key
  range_key  = aws_dynamodb_table.default_cloudwatch_alarms.range_key

  item = <<ITEM
{
  "name": {"S": "${var.item_name}"},
  "id": {"N": "${var.item_id}"},
  "config": {"S": "${replace(file(var.config_file), "\"", "\\\"")}"},
  "Data_type": {"S": "${var.data_type}"}
}
ITEM
}