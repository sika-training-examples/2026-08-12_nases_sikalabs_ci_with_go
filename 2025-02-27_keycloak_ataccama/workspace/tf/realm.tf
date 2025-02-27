resource "keycloak_realm" "example" {
  realm                          = "example"
  enabled                        = true
  display_name                   = "Example SSO"
  display_name_html              = "<h1>Example SSO</h1>"
  reset_password_allowed         = true
  registration_allowed           = true
  registration_email_as_username = false

  smtp_server {
    host = "maildev2.sikademo.com"
    port = "1025"
    from = "keycloak@kc0.com"
  }
}

resource "keycloak_realm_user_profile" "example" {
  realm_id = keycloak_realm.example.id

  attribute {
    name = "username"

    permissions {
      edit = ["admin"]
      view = ["user"]
    }
  }

  attribute {
    name = "email"

    permissions {
      edit = ["admin"]
      view = ["user"]
    }

    validator {
      name = "email"
    }
  }

  attribute {
    name = "firstName"

    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
  }

  attribute {
    name = "lastName"

    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
  }

  attribute {
    name         = "department"
    display_name = "Department"

    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
  }

  attribute {
    name = "xyz"

    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
  }

}
