resource "azurerm_virtual_network" "example" {
  name                = "generali2-example-network"
  resource_group_name = "generali2"
  location            = "westeurope"
  address_space       = ["10.0.0.0/8"]
}

resource "azurerm_virtual_network" "foo" {
  name                = "generali2-foo"
  resource_group_name = "generali2"
  location            = "westeurope"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "foo-default" {
  name                 = "default"
  resource_group_name  = azurerm_virtual_network.foo.resource_group_name
  virtual_network_name = azurerm_virtual_network.foo.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_virtual_network" "bar" {
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  name                = "generali2-bar"
  resource_group_name = "generali2"
}

resource "azurerm_subnet" "bar-default" {
  address_prefixes                              = ["10.0.2.0/24"]
  name                                          = "default"
  resource_group_name                           = azurerm_virtual_network.bar.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.bar.name
private_link_service_network_policies_enabled = false
}

resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  sku                 = "Standard"
  location            = "westeurope"
  resource_group_name = "generali2"
  allocation_method   = "Static"
}

resource "azurerm_lb" "example" {
  name                = "example-lb"
  sku                 = "Standard"
  location            = "westeurope"
  resource_group_name = "generali2"

  frontend_ip_configuration {
    name                 = azurerm_public_ip.example.name
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_subnet" "service" {
  name                                          = "service"
  resource_group_name                           = azurerm_virtual_network.bar.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.bar.name
  address_prefixes                              = ["10.0.1.0/24"]
  private_link_service_network_policies_enabled = false
}


resource "azurerm_private_link_service" "example" {
  name                = "example-privatelink"
  location            = "westeurope"
  resource_group_name = "generali2"

  nat_ip_configuration {
    name      = azurerm_public_ip.example.name
    primary   = true
    subnet_id = azurerm_subnet.service.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration[0].id,
  ]
}


resource "azurerm_private_endpoint" "example" {
  name                = "example-endpoint"
  location            = "westeurope"
  resource_group_name = azurerm_subnet.bar-default.resource_group_name
  subnet_id           = azurerm_subnet.bar-default.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_private_link_service.example.id
    is_manual_connection           = false
  }
}
