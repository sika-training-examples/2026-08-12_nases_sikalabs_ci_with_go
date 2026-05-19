resource "azurerm_container_group" "hello" {
  name                = "${local.prefix}-hello-world-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Private"
  os_type             = "Linux"
  subnet_ids          = [azurerm_subnet.subnet2_containers.id]

  container {
    name   = "hello-world"
    image  = "ghcr.io/sikalabs/hello-world-server"
    cpu    = "0.5"
    memory = "1.0"

    environment_variables = {
      PORT = 80
    }

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

output "hello_ip" {
  value = azurerm_container_group.hello.ip_address
}