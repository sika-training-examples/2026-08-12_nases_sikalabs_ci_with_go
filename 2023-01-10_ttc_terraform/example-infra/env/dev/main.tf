module "project-demo" {
  source = "../../modules/project-demo"
  config = {
    env          = "dev"
    ssh_key_name = "ondrej"
    vms = {
      a = {}
    }
  }
}

output "ips" {
  value = module.project-demo.ips
}
