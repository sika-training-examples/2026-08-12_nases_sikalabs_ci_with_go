terraform {
  backend "http" {}
}

resource "random_pet" "random" {
  length = 1
}

output "random_pet" {
  value = random_pet.random.id
}
