variable "filename" {
  type    = string
  default = "/home/soumen/study/terraform/terraform_basic/practice/p2/pets.txt"
}

variable "filename1" {
  type = list(string)
  default = [
    "/home/soumen/study/terraform/terraform_basic/practice/p2/cats.txt",
    "/home/soumen/study/terraform/terraform_basic/practice/p2/dogs.txt"
  ]
}

variable "content" {
  type = map(any)
  default = {
    "statement1" : "My favorite pet is "
    "statement2" : "We love animals!"
  }
}

variable "prefix" {
  default     = ["Mr", "Mrs", "Sir"]
  type        = list(string)
  description = "list of variables type"
}

variable "kitty" {
  type        = tuple([string, number, bool])
  default     = ["cat", 7, true]
  description = "list of variables with different type"
}

variable "seperator" {
  default = "."
}
variable "length" {
  default = "1"
}

variable "bella_obj" {
  type = object({
    name         = string
    color        = string
    age          = number
    food         = list(string)
    favorite_pet = bool
  })
  default = {
    name         = "bella"
    color        = "brown"
    age          = 7
    food         = ["fish", "chicken", "turkey"]
    favorite_pet = true
  }
}