resource "azurerm_public_ip" "pip" {
  name                = "pip-${local.prefix}-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${local.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
    primary                       = true
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${local.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B2s"

  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_username = "az"

  admin_ssh_key {
    username   = "az"
    public_key = local.ssh_public_key
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "aad_ssh_login" {
  name                 = "AADSSHLoginForLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADSSHLoginForLinux"
  type_handler_version = "1.0"
}

resource "azurerm_role_assignment" "vm_admin_login" {
  scope                =  azurerm_linux_virtual_machine.vm.id
  role_definition_name = "Virtual Machine Administrator Login"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "vm_admin_login2" {
  scope                =  azurerm_linux_virtual_machine.vm.id
  role_definition_name = "Virtual Machine Administrator Login"
  principal_id         = "0fdd1722-661a-4b94-9292-192544017b60" // ondrej@sika.io
}

output "vm_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "ssh" {
  value = "az ssh vm --subscription ${data.azurerm_client_config.current.subscription_id} -g ${azurerm_resource_group.rg.name} -n ${azurerm_linux_virtual_machine.vm.name}"
}
