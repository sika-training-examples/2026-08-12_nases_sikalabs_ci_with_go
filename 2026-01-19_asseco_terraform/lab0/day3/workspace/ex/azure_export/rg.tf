resource "azurerm_resource_group" "manual" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = {
    account    = "asseco-ce"
    team       = "asseco-infra-net-sk"
    created_at = timestamp()
  }

  location = "westeurope"
  name     = "x-manual-ondrejsika"
}
