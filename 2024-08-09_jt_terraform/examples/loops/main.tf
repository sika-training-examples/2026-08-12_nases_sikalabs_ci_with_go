resource "random_pet" "pet" {
  for_each = toset(["foo", "bar"])

  length    = 1
  separator = "-"
}

output "pet" {
  value = random_pet.pet
}

output "pet_ids" {
  value = {
    for k, v in random_pet.pet :
    k => v.id
  }
}
