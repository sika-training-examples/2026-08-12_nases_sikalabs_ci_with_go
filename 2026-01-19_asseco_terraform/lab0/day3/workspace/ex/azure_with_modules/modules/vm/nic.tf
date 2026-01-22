resource "azurerm_network_interface" "this" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = var.tags

  resource_group_name = var.resource_group_name
  location            = var.location

  name = "${var.name}-nic"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  count = length(var.network_security_group_ids)

  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = var.network_security_group_ids[count.index]
}
