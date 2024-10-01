terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

resource "random_pet" "foo" {
  length = 1
}

resource "random_pet" "bar" {
  length = 1
}

resource "random_pet" "baz" {
  length = 1
}

resource "random_pet" "aaa" {
  length = 1
}

output "pet_names" {
  value = [
    random_pet.foo.id,
    random_pet.bar.id,
    random_pet.baz.id,
    random_pet.aaa.id,
  ]
}
