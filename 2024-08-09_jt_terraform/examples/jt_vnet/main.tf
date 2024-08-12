terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "jt-net-example"
  location = "swedencentral"
}


module "hub-azsc-vnet-1" {
  source = "./azure_virtual_network"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  vnet = {
    name          = "hub-azsc-vnet-1"
    address_space = ["10.215.1.0/24"]
    subnets = {
      "fwfront-p-azsc-sub" = {
        address_prefixes = ["10.215.1.32/28"]
      }
      "fwback-p-azsc-sub" = {
        address_prefixes = ["10.215.1.48/28"]
      }
      ///this is a requirement from Azure to have it without any ids
      "GatewaySubnet" = {
        address_prefixes = ["10.215.1.0/27"]
      }
    }
    tags = {
      environment = "prod"
    }
  }
  vnet_peering = {
    # "HUBtoDNS" = {
    #   remote_virtual_network_id = "/subscriptions/..."
    #   allow_gateway_transit     = true
    #   allow_forwarded_traffic   = true
    # }
    # "HUBtoPROD" = {
    #   remote_virtual_network_id = "/subscriptions/..."
    #   allow_gateway_transit     = true
    #   allow_forwarded_traffic   = true
    # }
  }
}

module "vpngw-p-azsc-ro-01" {
  source              = "./azure_route_table"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  route_table = {
    name                                  = "vpngw-p-azsc-ro-01"
    disable_bgp_route_propagation         = false
    enable_subnet_route_table_association = true
    subnet_ids                            = [module.hub-azsc-vnet-1.subnet_ids["GatewaySubnet"]]
    route_entries = {
      VPN_to_Checkpoint = {
        address_prefix         = "10.215.0.0/16"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "10.215.1.52"
      }
      CHECKPOINT_TO_IDENTITY = {
        address_prefix         = "10.215.2.0/24"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "10.215.1.52"
      }
    }
  }
}

module "fwback-p-azsc-ro-01" {
  source              = "./azure_route_table"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  route_table = {
    name                                  = "fwback-p-azsc-ro-01"
    disable_bgp_route_propagation         = false
    enable_subnet_route_table_association = true
    subnet_ids                            = [module.hub-azsc-vnet-1.subnet_ids["fwback-p-azsc-sub"]]
    route_entries = {
      To-Internet = {
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "None"
      }
    }
    tags = {
      environment = "prod"
    }
  }
}

output "hub-azsc-vnet-1" {
  value = module.hub-azsc-vnet-1
}
