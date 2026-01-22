resource "azurerm_resource_group" "training" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = merge(local.common_tags, {})

  name     = "${local.prefix}-rg"
  location = local.location
}
