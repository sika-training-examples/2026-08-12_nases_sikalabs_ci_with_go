resource "elasticstack_elasticsearch_security_user" "cez" {
  username = "cez"

  password = "cezcez"
  roles = [
    elasticstack_kibana_security_role.hello-cez-read.id,
  ]
}
