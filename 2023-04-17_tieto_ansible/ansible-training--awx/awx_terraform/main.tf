terraform {
  required_providers {
    awx = {
      source  = "denouche/awx"
      version = "0.21.0"
    }
  }
}

variable "awx_hostname" {}
variable "awx_username" {}
variable "awx_password" {}

provider "awx" {
  hostname = var.awx_hostname
  username = var.awx_username
  password = var.awx_password
}

data "awx_organization" "default" {
  name = "Default"
}

# https://registry.terraform.io/providers/denouche/awx/latest/docs/resources/inventory
resource "awx_inventory" "ondrejsika" {
  name            = "tf-ondrejsika"
  organization_id = data.awx_organization.default.id
}

# https://registry.terraform.io/providers/denouche/awx/latest/docs/resources/host
resource "awx_host" "ondrejsika" {
  for_each = {
    "vm10.sikademo.com" = null
  }

  name         = each.key
  inventory_id = awx_inventory.ondrejsika.id
  enabled      = true
}

# https://registry.terraform.io/providers/denouche/awx/latest/docs/resources/credential_machine
resource "awx_credential_machine" "default" {
  lifecycle {
    ignore_changes = [
      ssh_key_data,
      ssh_public_key_data,
    ]
  }

  organization_id     = data.awx_organization.default.id
  name                = "tf-default"
  ssh_key_data        = file("id_rsa_lab")
  ssh_public_key_data = file("id_rsa_lab.pub")
}

# https://registry.terraform.io/providers/denouche/awx/latest/docs/resources/project
resource "awx_project" "hello-world-server" {
  name                 = "tf-hello-world-server-example"
  scm_type             = "git"
  scm_url              = "https://github.com/sika-training-examples/2023-04-18_tieto_ansible_example_project.git"
  scm_branch           = "test"
  scm_update_on_launch = true
  organization_id      = data.awx_organization.default.id
}

# https://registry.terraform.io/providers/denouche/awx/latest/docs/resources/job_template
resource "awx_job_template" "hello-world-server" {
  name         = "tf-hello-world-server"
  job_type     = "run"
  inventory_id = awx_inventory.ondrejsika.id
  project_id   = awx_project.hello-world-server.id
  playbook     = "site.yml"
}

# https://registry.terraform.io/providers/denouche/awx/latest/docs/resources/job_template_credential
resource "awx_job_template_credential" "hello-world-server" {
  job_template_id = awx_job_template.hello-world-server.id
  credential_id   = awx_credential_machine.default.id
}

# https://registry.terraform.io/providers/denouche/awx/latest/docs/resources/schedule
resource "awx_schedule" "main" {
  name                    = "main"
  rrule                   = "DTSTART;TZID=Europe/Prague:20220101T000000 RRULE:INTERVAL=1;FREQ=MINUTELY"
  unified_job_template_id = awx_job_template.hello-world-server.id
  inventory               = awx_inventory.ondrejsika.id
}
