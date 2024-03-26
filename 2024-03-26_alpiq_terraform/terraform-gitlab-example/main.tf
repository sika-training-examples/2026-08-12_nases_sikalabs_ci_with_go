terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "16.10.0"
    }
  }
}

provider "gitlab" {
  base_url = "https://gitlab.sikademo.com/api/v4/"
  token    = "xxx"
}

data "gitlab_project" "example" {
  path_with_namespace = "exampke/example"
}

resource "gitlab_project_variable" "example-tf-vars" {
  for_each = {
    aws_access_key = "xxx"
    aws_secret_key = "xxx"
    prefix         = "ondrej"
  }

  project   = data.gitlab_project.example.id
  key       = "TF_VAR_${each.key}"
  value     = each.value
  protected = false
}
