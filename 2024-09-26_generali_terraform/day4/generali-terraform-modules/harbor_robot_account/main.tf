resource "harbor_robot_account" "account" {
  name        = var.robot_account_name
  description = "project level robot account"
  level       = "project"
  permissions {
    access {
      action   = "pull"
      resource = "repository"
    }
    kind      = "project"
    namespace = var.project_name
  }
}
