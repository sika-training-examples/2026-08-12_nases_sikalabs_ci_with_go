resource "azurerm_resource_group" "asseco-terraform-states" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  name     = "asseco-terraform-states"
  location = "westeurope"

  tags = {
    team       = "cz-cloud-praha"
    created_at = timestamp()
  }
}
