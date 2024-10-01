output "subntet_ids" {
  value = {
    for subnet in azurerm_subnet.this :
    subnet.name => subnet.id
  }
}
