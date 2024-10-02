output "project_name" {
  value = var.project_name
}

output "robot_username" {
  value = harbor_robot_account.account.full_name
}

output "robot_password" {
  value = harbor_robot_account.account.secret
}
