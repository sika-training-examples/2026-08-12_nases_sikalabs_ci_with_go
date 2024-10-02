resource "harbor_project" "project" {
  name                   = var.project_name
  public                 = var.public
  vulnerability_scanning = true
}

resource "harbor_project_member_user" "project_admin" {
  for_each   = toset(var.project_admins)
  project_id = harbor_project.project.id
  user_name  = each.value
  role       = "projectadmin"
}
