resource "rancher2_project" "this" {
  name       = var.name
  cluster_id = var.cluster_id

  resource_quota {
    project_limit {
      limits_cpu       = var.project_limit_cpu
      limits_memory    = var.project_limit_memory
      requests_storage = var.project_limit_storage
    }
    namespace_default_limit {
      limits_cpu       = var.namespace_default_limit_cpu
      limits_memory    = var.namespace_default_limit_memory
      requests_storage = var.namespace_default_limit_storage
    }
  }
}

resource "rancher2_namespace" "this" {
  lifecycle {
    ignore_changes = [
      labels["kubernetes.io/metadata.name"],
    ]
  }

  name       = rancher2_project.this.name
  project_id = rancher2_project.this.id

  container_resource_limit {
    limits_cpu      = "100m"
    limits_memory   = "200Mi"
    requests_cpu    = "50m"
    requests_memory = "50Mi"
  }
}

resource "rancher2_registry" "this" {
  name = "harbor-robot"

  project_id   = rancher2_project.this.id
  namespace_id = rancher2_namespace.this.id

  registries {
    address  = var.registry
    username = var.registry_username
    password = var.registry_password
  }
}
