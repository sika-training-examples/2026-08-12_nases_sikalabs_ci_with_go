module "project-demo" {
  source = "../../modules/project-demo"
  config = {
    env          = "prod"
    ssh_key_name = "ondrej"
    vms = {
      a = {}
      b = {}
    }
  }
}

output "ips" {
  value = module.project-demo.ips
}
