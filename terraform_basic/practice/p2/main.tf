terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "1.4.0"
    }
  }
}


resource "local_file" "pet" {
  # filename = var.filename
  filename = each.value
  for_each = toset(var.filename1)
  content  = "${var.content["statement1"]} ${random_pet.my-pet.id}" #interpulation sequence

  file_permission = "0700"

  # life cycle rule
  lifecycle {
    create_before_destroy = true
  }

  # explicit dependency
  depends_on = [
    random_pet.my-pet
  ]

}

resource "random_pet" "my-pet" {
  prefix    = var.prefix[1]
  separator = var.seperator
  length    = var.length
}

output "content" {
  value       = var.content["statement1"]
  description = "print the content of the file"
}

output "pet-name" {
  value       = random_pet.my-pet.id
  description = "Record the value of PetId genarated by random_per resurces"
}