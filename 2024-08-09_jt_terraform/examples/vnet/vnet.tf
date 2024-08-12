module "vnets" {
  source = "./modules/vnet"

  resource_group_name = module.resource_groups.resource_group_names["${var.root_id}-FW-T-AZSC-RG-01"]
  location            = var.primary_location

  vnet = {
    "${var.root_id}-HUB-AZSC-VNET-01" = {
      address_space = ["10.207.1.0/24"]
      subnets = {
        "${var.root_id}-FWFRONT-T-AZSC-SUB" = {
          address_prefixes = ["10.207.1.32/28"]
        }
        "${var.root_id}-FWBACK-T-AZSC-SUB" = {
          address_prefixes = ["10.207.1.48/28"]
        }
        ///this is a requirement from Azure to have it without any ids
        "GatewaySubnet" = {
          address_prefixes = ["10.207.1.0/27"]
        }
      }
      tags = {
        environment = "dev"
      }
    }
  }

  route_tables = {
    "${var.root_id}-VPNGW-P-AZSC-RO-01" = {
      disable_bgp_route_propagation         = false
      enable_subnet_route_table_association = true
      subnet_ids                            = [module.vnets.subnet_ids["GatewaySubnet"]]
      route_entries = {
        VPN_to_Checkpoint = {
          address_prefix         = "10.207.0.0/16"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.207.1.53"
        }
        CHECKPOINT_TO_IDENTITY = {
          address_prefix         = "10.207.2.0/24"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.207.1.53"
        }
      }
      tags = {
        environment = "dev"
      }
    }
    "${var.root_id}-fwback-t-azsc-ro-01" = {
      disable_bgp_route_propagation         = false
      enable_subnet_route_table_association = true
      subnet_ids                            = [module.vnets.subnet_ids["${var.root_id}-FWBACK-T-AZSC-SUB"]]
      route_entries = {
        To-Internet = {
          address_prefix = "0.0.0.0/0"
          next_hop_type  = "None"
        }
      }
      tags = {
        environment = "dev"
      }
    }
    "${var.root_id}-fwfront-t-azsc-ro-01" = {
      disable_bgp_route_propagation         = false
      enable_subnet_route_table_association = true
      subnet_ids                            = [module.vnets.subnet_ids["${var.root_id}-FWFRONT-T-AZSC-SUB"]]
      route_entries = {
        Local-Subnet = {
          address_prefix = "10.207.1.32/28"
          next_hop_type  = "VnetLocal"
        }
        To-Internal-0 = {
          address_prefix = "10.207.1.0/24"
          next_hop_type  = "None"
        }
      }
      tags = {
        environment = "dev"
      }
    }
  }

  vnet_peering = {
    "HUBtoDNS" = {
      virtual_network_name      = module.vnets.vnet_names["${var.root_id}-HUB-AZSC-VNET-01"]
      remote_virtual_network_id = "/subscriptions/bd67cf40-d13f-43e0-9f77-1470312688bf/resourceGroups/JTFGTEST-networkhub-t-azsc-rg-01/providers/Microsoft.Network/virtualNetworks/JTFGTEST-dns-azsc-vnet-2"
      allow_gateway_transit     = true
      allow_forwarded_traffic   = true
    }
    "HUBtoMNG" = {
      virtual_network_name      = module.vnets.vnet_names["${var.root_id}-HUB-AZSC-VNET-01"]
      remote_virtual_network_id = "/subscriptions/7bf66bb3-bd8e-4b84-bb28-3c71cf088150/resourceGroups/JTFGTEST-NETWORK-T-AZSC-RG-01/providers/Microsoft.Network/virtualNetworks/JTFGTEST-mng-azsc-vnet-192"
      allow_gateway_transit     = true
      allow_forwarded_traffic   = true
    }
    "HUBtoINNOSandbox" = {
      virtual_network_name      = module.vnets.vnet_names["${var.root_id}-HUB-AZSC-VNET-01"]
      remote_virtual_network_id = "/subscriptions/e6407d61-59e7-4d86-a088-0f8062da02a7/resourceGroups/JTFGTEST-networkinnosandbox-t-azsc-rg-01/providers/Microsoft.Network/virtualNetworks/JTFGTEST-innosandbox-azsc-vnet-100"
      allow_gateway_transit     = true
      allow_forwarded_traffic   = true
    }
  }
}
module "networking_primary_location" {
  source = "../../modules/azure_virtual_network"

  resource_group_name = module.resource_groups.resource_group_names["${var.root_id}-networkhub-t-azsc-rg-01"]
  location            = var.primary_location

  vnet = {
    "${var.root_id}-dns-azsc-vnet-2" = {
      address_space = ["10.207.2.0/24"]
      subnets = {
        "${var.root_id}-dns-azsc-sub-inboundsubnet" = {
          address_prefixes = ["10.207.2.64/28"]
          service_delegation = {
            inboundsubnet-delegation = {
              actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
              name    = "Microsoft.Network/dnsResolvers"
            }
          }
        }
        "${var.root_id}-dns-azsc-sub-outboundsubnet" = {
          address_prefixes = ["10.207.2.32/28"]
          service_delegation = {
            outboundsubnet-delegation = {
              actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
              name    = "Microsoft.Network/dnsResolvers"
            }
          }
        }
      }
      tags = {
        environment = "dev"
      }
    }
  }


  route_tables = {
    "${var.root_id}-dns-t-azsc-ro-01" = {
      disable_bgp_route_propagation         = true
      enable_subnet_route_table_association = true
      subnet_ids = [module.networking_primary_location.subnet_ids["${var.root_id}-dns-azsc-sub-inboundsubnet"],
      module.networking_primary_location.subnet_ids["${var.root_id}-dns-azsc-sub-outboundsubnet"]]
      route_entries = {
        DNS_TO_CHECKPOINT = {
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.207.1.53"
        }
      }
      tags = {
        environment = "dev"
      }
    }
  }



  vnet_peering = {
    "DNStoHUB" = {
      virtual_network_name      = module.networking_primary_location.vnet_names["${var.root_id}-dns-azsc-vnet-2"]
      remote_virtual_network_id = var.vnet_hub_id
      allow_gateway_transit     = false
      allow_forwarded_traffic   = true
      use_remote_gateways       = true
    }
  }
}


module "vnets" {
  source = "../../modules/azure_virtual_network"

  resource_group_name = module.resource_groups.resource_group_names["${var.root_id}-FW-T-AZSC-RG-01"]
  location            = var.primary_location

  vnet = {
    "${var.root_id}-HUB-AZSC-VNET-01" = {
      address_space = ["10.207.1.0/24"]
      subnets = {
        "${var.root_id}-FWFRONT-T-AZSC-SUB" = {
          address_prefixes = ["10.207.1.32/28"]
        }
        "${var.root_id}-FWBACK-T-AZSC-SUB" = {
          address_prefixes = ["10.207.1.48/28"]
        }
        ///this is a requirement from Azure to have it without any ids
        "GatewaySubnet" = {
          address_prefixes = ["10.207.1.0/27"]
        }
      }
      tags = {
        environment = "dev"
      }
    }
  }

  route_tables = {
    "${var.root_id}-VPNGW-P-AZSC-RO-01" = {
      disable_bgp_route_propagation         = false
      enable_subnet_route_table_association = true
      subnet_ids                            = [module.vnets.subnet_ids["GatewaySubnet"]]
      route_entries = {
        VPN_to_Checkpoint = {
          address_prefix         = "10.207.0.0/16"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.207.1.53"
        }
        CHECKPOINT_TO_IDENTITY = {
          address_prefix         = "10.207.2.0/24"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.207.1.53"
        }
      }
      tags = {
        environment = "dev"
      }
    }
    "${var.root_id}-fwback-t-azsc-ro-01" = {
      disable_bgp_route_propagation         = false
      enable_subnet_route_table_association = true
      subnet_ids                            = [module.vnets.subnet_ids["${var.root_id}-FWBACK-T-AZSC-SUB"]]
      route_entries = {
        To-Internet = {
          address_prefix = "0.0.0.0/0"
          next_hop_type  = "None"
        }
      }
      tags = {
        environment = "dev"
      }
    }
    "${var.root_id}-fwfront-t-azsc-ro-01" = {
      disable_bgp_route_propagation         = false
      enable_subnet_route_table_association = true
      subnet_ids                            = [module.vnets.subnet_ids["${var.root_id}-FWFRONT-T-AZSC-SUB"]]
      route_entries = {
        Local-Subnet = {
          address_prefix = "10.207.1.32/28"
          next_hop_type  = "VnetLocal"
        }
        To-Internal-0 = {
          address_prefix = "10.207.1.0/24"
          next_hop_type  = "None"
        }
      }
      tags = {
        environment = "dev"
      }
    }
  }

  vnet_peering = {
    "HUBtoDNS" = {
      virtual_network_name      = module.vnets.vnet_names["${var.root_id}-HUB-AZSC-VNET-01"]
      remote_virtual_network_id = "/subscriptions/bd67cf40-d13f-43e0-9f77-1470312688bf/resourceGroups/JTFGTEST-networkhub-t-azsc-rg-01/providers/Microsoft.Network/virtualNetworks/JTFGTEST-dns-azsc-vnet-2"
      allow_gateway_transit     = true
      allow_forwarded_traffic   = true
    }
    "HUBtoMNG" = {
      virtual_network_name      = module.vnets.vnet_names["${var.root_id}-HUB-AZSC-VNET-01"]
      remote_virtual_network_id = "/subscriptions/7bf66bb3-bd8e-4b84-bb28-3c71cf088150/resourceGroups/JTFGTEST-NETWORK-T-AZSC-RG-01/providers/Microsoft.Network/virtualNetworks/JTFGTEST-mng-azsc-vnet-192"
      allow_gateway_transit     = true
      allow_forwarded_traffic   = true
    }
    "HUBtoINNOSandbox" = {
      virtual_network_name      = module.vnets.vnet_names["${var.root_id}-HUB-AZSC-VNET-01"]
      remote_virtual_network_id = "/subscriptions/e6407d61-59e7-4d86-a088-0f8062da02a7/resourceGroups/JTFGTEST-networkinnosandbox-t-azsc-rg-01/providers/Microsoft.Network/virtualNetworks/JTFGTEST-innosandbox-azsc-vnet-100"
      allow_gateway_transit     = true
      allow_forwarded_traffic   = true
    }
  }
}
module "networking_primary_location" {
  source = "../../modules/azure_virtual_network"

  resource_group_name = module.resource_groups.resource_group_names["${var.root_id}-networkhub-t-azsc-rg-01"]
  location            = var.primary_location

  vnet = {
    "${var.root_id}-dns-azsc-vnet-2" = {
      address_space = ["10.207.2.0/24"]
      subnets = {
        "${var.root_id}-dns-azsc-sub-inboundsubnet" = {
          address_prefixes = ["10.207.2.64/28"]
          service_delegation = {
            inboundsubnet-delegation = {
              actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
              name    = "Microsoft.Network/dnsResolvers"
            }
          }
        }
        "${var.root_id}-dns-azsc-sub-outboundsubnet" = {
          address_prefixes = ["10.207.2.32/28"]
          service_delegation = {
            outboundsubnet-delegation = {
              actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
              name    = "Microsoft.Network/dnsResolvers"
            }
          }
        }
      }
      tags = {
        environment = "dev"
      }
    }
  }


  route_tables = {
    "${var.root_id}-dns-t-azsc-ro-01" = {
      disable_bgp_route_propagation         = true
      enable_subnet_route_table_association = true
      subnet_ids = [module.networking_primary_location.subnet_ids["${var.root_id}-dns-azsc-sub-inboundsubnet"],
      module.networking_primary_location.subnet_ids["${var.root_id}-dns-azsc-sub-outboundsubnet"]]
      route_entries = {
        DNS_TO_CHECKPOINT = {
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = "10.207.1.53"
        }
      }
      tags = {
        environment = "dev"
      }
    }
  }



  vnet_peering = {
    "DNStoHUB" = {
      virtual_network_name      = module.networking_primary_location.vnet_names["${var.root_id}-dns-azsc-vnet-2"]
      remote_virtual_network_id = var.vnet_hub_id
      allow_gateway_transit     = false
      allow_forwarded_traffic   = true
      use_remote_gateways       = true
    }
  }
}
