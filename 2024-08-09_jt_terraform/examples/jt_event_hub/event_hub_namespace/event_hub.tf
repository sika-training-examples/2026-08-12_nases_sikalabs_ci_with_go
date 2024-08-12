resource "azurerm_eventhub_namespace" "this" {
  name                          = var.event_hub_namespace.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.event_hub_namespace.sku
  capacity                      = var.event_hub_namespace.capacity
  public_network_access_enabled = var.event_hub_namespace.public_network_access_enabled

  tags = var.event_hub_namespace.tags
}

resource "azurerm_eventhub" "this" {
  for_each = var.event_hub_namespace.event_hubs

  name                = each.key
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.resource_group_name
  partition_count     = each.value.partition_count
  message_retention   = each.value.message_retention
}

resource "azurerm_role_assignment" "eventhubnames_namespace" {
  for_each = toset(var.event_hub_namespace.receiver_principal_ids)

  role_definition_name = "Azure Event Hubs Data Receiver"
  scope                = azurerm_eventhub_namespace.this.id
  principal_id         = each.key
}
