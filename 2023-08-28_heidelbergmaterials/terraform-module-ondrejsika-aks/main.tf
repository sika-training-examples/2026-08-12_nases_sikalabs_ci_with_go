terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.13.0"
    }
  }
}

variable "location" {}
variable "common_tags" {}
variable "name" {}
variable "dns_record_name" {}
variable "node_count" {}
variable "node_size" {}
variable "cloudflare_zone_id" {}

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = merge(var.common_tags, )
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_kubernetes_cluster" "this" {
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  name       = var.name
  dns_prefix = join("", regexall("[a-z0-9]+", lower(var.name)))

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.common_tags, )
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_public_ip" "ingress" {
  name                = "${var.name}-ingress"
  resource_group_name = azurerm_kubernetes_cluster.this.node_resource_group
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(var.common_tags, )
  lifecycle { ignore_changes = [tags] }
}


resource "cloudflare_record" "ingress" {
  zone_id = var.cloudflare_zone_id
  name    = var.dns_record_name
  value   = azurerm_public_ip.ingress.ip_address
  type    = "A"
}

resource "cloudflare_record" "ingress_wildcard" {
  zone_id = var.cloudflare_zone_id
  name    = "*.${cloudflare_record.ingress.name}"
  value   = cloudflare_record.ingress.hostname
  type    = "CNAME"
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}

output "ingress_resource_group_name" {
  value = azurerm_public_ip.ingress.resource_group_name
}

output "ingress_ip" {
  value = azurerm_public_ip.ingress.ip_address
}

output "ingress_base_domain" {
  value = cloudflare_record.ingress.hostname
}
