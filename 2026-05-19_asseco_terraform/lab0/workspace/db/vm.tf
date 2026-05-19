resource "azurerm_linux_virtual_machine" "example" {
  name                = "${local.prefix}-vm-example"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"
  admin_username      = "az"

  network_interface_ids = [azurerm_network_interface.vm.id]

  admin_ssh_key {
    username   = "az"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "example_ip" {
  value = azurerm_public_ip.vm.ip_address
}
