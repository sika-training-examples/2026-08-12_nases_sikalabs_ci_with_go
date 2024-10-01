module "postgres" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//postgres?ref=master"

  name           = "${var.env}-generali-counter-${var.suffix}"
  databases      = ["counter"]
  firewall_rules = var.firewall_rules
}

output "postgres" {
  value     = module.postgres
  sensitive = true
}
