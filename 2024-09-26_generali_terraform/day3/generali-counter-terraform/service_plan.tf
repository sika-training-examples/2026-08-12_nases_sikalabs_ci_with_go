module "service_plan" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//service_plan?ref=master"

  name     = "${var.env}-generali-counter-${var.suffix}"
  sku_name = "P1v2"
}
