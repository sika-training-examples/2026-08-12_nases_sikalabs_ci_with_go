module "bar_harbor" {
  source       = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//harbor_project?ref=master"
  project_name = "bar"
}

module "bar_harbor_robot_account" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//harbor_robot_account?ref=master"

  project_name       = module.bar_harbor.project_name
  robot_account_name = "bar"
}

module "bar_project" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//rancher_project?ref=master"

  name       = "bar"
  cluster_id = module.cluster_info.cluster_id

  registry          = "harbor.k8s.sikademo.com"
  registry_username = module.bar_harbor_robot_account.robot_username
  registry_password = module.bar_harbor_robot_account.robot_password
}
