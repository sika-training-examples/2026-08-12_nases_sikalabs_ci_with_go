resource "azurerm_resource_group" "example" {
  name     = "example-generali-ondrejsika"
  location = "westeurope"
}

data "azurerm_subnet" "ondrejsika" {
  name                 = "ondrejsika"
  virtual_network_name = "example-generali-network"
  resource_group_name  = "example-generali-network"
}

output "subnet_id" {
  value = data.azurerm_subnet.ondrejsika.id
}

module "service_plan" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//service_plan?ref=master"

  name     = "ondrejsika"
  sku_name = "P1v2"
}

module "generali_acr" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//acr?ref=master"

  name = "generali"
}

module "hello_world_webapp" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//webapp?ref=master"

  name                = "example-generali-ondrejsika-hello-world"
  resource_group_name = module.service_plan.resource_group_name
  location            = module.service_plan.resource_group_location
  service_plan_id     = module.service_plan.service_plan_id
  docker_image_name   = "ondrejsika/training-example"
  docker_registry_url = "https://docker.io"
}

output "hello_world_url" {
  value = "https://${module.hello_world_webapp.default_hostname}"
}


module "iceland_webapp" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//webapp"

  name                = "example-generali-ondrejsika-iceland"
  resource_group_name = module.service_plan.resource_group_name
  location            = module.service_plan.resource_group_location
  service_plan_id     = module.service_plan.service_plan_id
  docker_image_name   = "ondrejsika/iceland-2"
  docker_registry_url = "https://docker.io"
}

output "iceland_url" {
  value = "https://${module.iceland_webapp.default_hostname}"
}

locals {
  counter_possible_outbound_ip_address_list = [
    "20.76.64.123",
    "20.76.68.160",
    "20.76.68.161",
    "20.76.70.134",
    "20.76.70.135",
    "20.76.70.242",
    "20.105.224.34",
  ]
}

module "ondrejsika_postgres" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//postgres?ref=master"

  name      = "example-generali-ondrejsika-postgres"
  databases = ["counter"]
  firewall_rules = merge({
    "sikalabs_office" = {
      start_ip_address = "85.160.75.232"
      end_ip_address   = "85.160.75.232"
    }
    }, {
    for ip in local.counter_possible_outbound_ip_address_list :
    replace(ip, ".", "-") => {
      start_ip_address = ip
      end_ip_address   = ip
    }
  })
}

output "postgres" {
  value     = module.ondrejsika_postgres
  sensitive = true
}

module "counter_webapp" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//webapp?ref=master"

  name                = "example-generali-ondrejsika-counter"
  resource_group_name = module.service_plan.resource_group_name
  location            = module.service_plan.resource_group_location
  service_plan_id     = module.service_plan.service_plan_id
  docker_image_name   = "ondrejsika/wip-counter-ssl"
  docker_registry_url = "https://docker.io"
  env = {
    BACKEND           = "postgres"
    POSTGRES_HOST     = module.ondrejsika_postgres.host
    POSTGRES_PASSWORD = module.ondrejsika_postgres.password
    POSTGRES_USER     = module.ondrejsika_postgres.username
    POSTGRES_DATABASE = "counter"
  }
}

output "counter_url" {
  value = "https://${module.counter_webapp.default_hostname}"
}
