terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "15.8.0"
    }
  }
}

provider "gitlab" {
  base_url = "https://gitlab.sikademo.com/api/v4"
  token    = "xxx"
}

resource "gitlab_project_variable" "example" {
  for_each = {
    GITLAB_DOMAIN               = "gitlab.sikademo.com"
    GITLAB_PROJECT_ID           = "374"
    GITLAB_USERNAME             = "ondrejsika"
    GITLAB_TOKEN                = "xxx"
    TF_VAR_aws_access_key       = "xxx"
    TF_VAR_aws_secret_key       = "xxx"
    TF_VAR_cloudflare_api_token = "xxx"
  }
  project   = "374"
  key       = each.key
  value     = each.value
  protected = false
}
