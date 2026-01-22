resource "azurerm_network_interface" "vm1" {
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location

  name = "${azurerm_resource_group.training.name}-vm1-nic"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.net1-default.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.10.0.101"
    public_ip_address_id          = azurerm_public_ip.ip-1.id
  }
}

resource "azurerm_network_interface_security_group_association" "vm1-allow22" {
  network_interface_id      = azurerm_network_interface.vm1.id
  network_security_group_id = azurerm_network_security_group.allow22.id
}

resource "azurerm_linux_virtual_machine" "vm1" {
  resource_group_name = azurerm_resource_group.training.name
  location            = azurerm_resource_group.training.location

  name = "${azurerm_resource_group.training.name}-vm1"
  size = "Standard_B1ls" // 1 CPU, 0.5 RAM https://cloudprice.net/vm/Standard_B1ls

  network_interface_ids = [
    azurerm_network_interface.vm1.id,
  ]

  admin_username = "azadmin"
  admin_ssh_key {
    username   = "azadmin"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmPePobYm8Pl/V6OscZSYR3iDoAs9tVLBCCC2RpK/rRLzlTa5SqqdviWXLaNDSURRq1InKDNZs8UBcEzX6W00uV89ekXkhYf+TW2dIL/SeLQ2zIF7qX387J/A8+H6QtQX4DMzrz7xkWld3oDbC8Tol5sEpsQRFwW781Q8Zf6ZAA+eeN6kBUsii3iYJ736iDI8zHHOBofDn07jMNjEkNFRMoblmBwpqcfLXDjnolvtGSeIL9wede2bDQ0QKUPkanTXoNcHVEkGGGITmgAu6TZtRUXu2ESWF4toUPQ5Jznhi819IbapUYy6UAnS61b3jN2+VgKTHetuikr/Wni5IrvvvBVfBWGlQ37WHP+8JjM/7F9oNJ8bWIyICb3CGxr5py/E5SDPqZl8gz4I1hHaFCfP9bkyb+iMp60dWbG1jfdBOJeC+8TTkt3aHQv206gY7mSofzDn4zSvSM3alcqK8IVoQBiYWFJiqgwOfybOHM9kOEt66jB/KUNhaf/3hQMA0OZE= root@lab0"
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

output "ssh_vm1" {
  value = "ssh azadmin@${azurerm_public_ip.ip-1.ip_address}"
}
