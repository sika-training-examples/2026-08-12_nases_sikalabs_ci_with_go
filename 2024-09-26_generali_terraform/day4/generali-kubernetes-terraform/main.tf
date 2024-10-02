module "cluster_info" {
  source       = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//cluster_info?ref=master"
  cluster_name = "local"
}
