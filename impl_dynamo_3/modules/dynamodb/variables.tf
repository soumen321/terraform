variable "table_name" {
  type = string
}

variable "billing_mode" {
  type = string
}

variable "read_capacity" {
  type = number
}

variable "write_capacity" {
  type = number
}

variable "hash_key" {
  type = string
}

variable "range_key" {
  type = string
}

variable "config_file" {
  type = string
}

variable "item_name" {
  type = string
}

variable "item_id" {
  type = number
}

variable "data_type" {
  type = string
}

variable "tags" {
  type = map(string)
}