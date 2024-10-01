resource "random_pet" "random_pet" {
  count = 2

  length = 1
  provisioner "local-exec" {
    command = "echo hello ${self.id}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo bye ${self.id}"
  }
}
