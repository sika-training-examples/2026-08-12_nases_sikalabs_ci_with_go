resource "vault_auth_backend" "local_cluster" {
  type = "kubernetes"
  path = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "test_cluster_config" {
  backend            = vault_auth_backend.local_cluster.path
  kubernetes_host    = "https://kubernetes.default.svc.cluster.local"
  token_reviewer_jwt = "" # Leave empty as per the requirement
}

resource "vault_kubernetes_auth_backend_role" "external_secrets" {
  backend                          = vault_auth_backend.local_cluster.path
  role_name                        = "external-secrets"
  bound_service_account_names      = ["external-secrets"]
  bound_service_account_namespaces = ["external-secrets"]
  token_policies                   = [vault_policy.read-all.name]
  token_ttl                        = 3600
}

resource "vault_kubernetes_auth_backend_role" "counter_dev" {
  backend                          = vault_auth_backend.local_cluster.path
  role_name                        = "counter-dev"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["pss-counter-dev"]
  token_policies                   = [vault_policy.read-all.name]
  token_ttl                        = 3600
}

resource "vault_kubernetes_auth_backend_role" "counter_prod" {
  backend                          = vault_auth_backend.local_cluster.path
  role_name                        = "counter-prod"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["pss-counter-prod"]
  token_policies                   = [vault_policy.read-all.name]
  token_ttl                        = 3600
}

resource "vault_kubernetes_auth_backend_role" "labapp" {
  backend                          = vault_auth_backend.local_cluster.path
  role_name                        = "labapp"
  bound_service_account_names      = ["default"]
  bound_service_account_namespaces = ["labapp"]
  token_policies                   = [vault_policy.read-all.name]
  token_ttl                        = 3600
}
