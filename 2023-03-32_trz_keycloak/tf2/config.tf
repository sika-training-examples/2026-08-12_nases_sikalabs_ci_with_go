locals {
  users = {
    "ondrej" = {
      email      = "ondrej@example.com"
      first_name = "Ondrej"
      last_name  = "Sika"
      enabled    = true
      groups     = ["admins", "editors", "viewers", "argocd-admins"]
      department = "IT"
    }
    "vojtech" = {
      email      = "vojtech@example.com"
      first_name = "Vojtech"
      last_name  = "Mares"
      enabled    = true
      groups     = ["editors", "viewers", "argocd-readers"]
      department = "Support"
    }
    "alice" = {
      email      = "alice@example.com"
      first_name = "Alice"
      last_name  = "A"
      enabled    = true
      groups     = ["viewers"]
      department = "Support"
    }
    "bob" = {
      email      = "bob@example.com"
      first_name = "Bob"
      last_name  = "B"
      enabled    = true
      groups     = []
      department = "Support"
    }
  }
}

locals {
  roles = {
    "foo-editor" = {}
    "foo-viewer" = {}
    "bar-editor" = {}
    "bar-viewer" = {}
  }
}

locals {
  groups = {
    "admins" = {
      roles = ["foo-editor", "bar-editor"]
    }
    "editors" = {
      roles = ["foo-editor", "bar-editor"]
    }
    "viewers" = {
      roles = ["foo-viewer", "bar-viewer"]
    }
    "argocd-admins" = {
      roles = []
    }
    "argocd-readers" = {
      roles = []
    }
  }
}
