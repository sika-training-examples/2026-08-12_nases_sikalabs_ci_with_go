module "counter" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//webapp?ref=master"

  name                = "${var.env}-generali-counter-${var.suffix}"
  resource_group_name = module.service_plan.resource_group_name
  location            = module.service_plan.resource_group_location
  service_plan_id     = module.service_plan.service_plan_id
  docker_image_name   = "ondrejsika/wip-counter-ssl"
  docker_registry_url = "https://docker.io"
  env = {
    BACKEND           = "postgres"
    POSTGRES_HOST     = module.postgres.host
    POSTGRES_PASSWORD = module.postgres.password
    POSTGRES_USER     = module.postgres.username
    POSTGRES_DATABASE = "counter"
  }
  worker_count = var.replicas
}

output "counter_url" {
  value = "https://${module.counter.default_hostname}"
}
