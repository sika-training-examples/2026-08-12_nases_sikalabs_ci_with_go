resource "azurerm_linux_virtual_machine" "this" {
  lifecycle {
    ignore_changes = [
      tags["created_at"]
    ]
  }

  tags = var.tags

  resource_group_name = var.resource_group_name
  location            = var.location

  name = var.name
  size = var.size

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_username = "azadmin"
  admin_ssh_key {
    username   = "azadmin"
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-13"
    sku       = "13"
    version   = "latest"
  }
}

