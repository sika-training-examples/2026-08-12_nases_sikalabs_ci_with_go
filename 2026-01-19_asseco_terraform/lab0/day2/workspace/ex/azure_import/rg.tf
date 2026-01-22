resource "azurerm_resource_group" "manual-postgres" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = {
    team       = "cz-cloud-brno"
    created_at = timestamp()
  }

  location = "westeurope"
  name     = "manual-postgres"
}
