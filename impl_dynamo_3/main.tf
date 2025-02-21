provider "aws" {
  region = var.region
}

module "dynamodb" {
  source = "./modules/dynamodb"

  for_each = var.tables

  table_name     = each.value.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "name"
  range_key      = "id"
  config_file    = each.value.config_file
  item_name      = each.value.item_name
  item_id        = each.value.item_id
  data_type      = each.value.data_type
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}