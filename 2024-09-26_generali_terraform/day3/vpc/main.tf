module "example_generali_network" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//network?ref=master"

  name          = "example-generali-network"
  address_space = ["10.0.0.0/16"]

  subnets = {
    "ondrejsika" = ["10.0.1.0/24"]
    "foo"        = ["10.0.2.0/24"]
  }
}

module "hello_world_network" {
  source = "git::https://gitlab.sikademo.com/generali/generali-terraform-modules.git//network?ref=master"

  name          = "hello-world"
  address_space = ["10.0.0.0/16"]

  subnets = {
    "foo" = ["10.0.1.0/24"]
    "bar" = ["10.0.2.0/24"]
  }
}
