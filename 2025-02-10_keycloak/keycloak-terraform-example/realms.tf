locals {
  realms = {
    prod = keycloak_realm.prod.id,
    test = keycloak_realm.test.id,
  }
}
