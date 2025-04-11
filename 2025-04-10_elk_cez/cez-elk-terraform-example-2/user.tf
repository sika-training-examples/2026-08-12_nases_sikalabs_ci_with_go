resource "elasticstack_elasticsearch_security_user" "cez" {
  username = "cez"

  password = "cezcez"
  roles = [
    elasticstack_kibana_security_role.hello-cez-read.id,
  ]
}

resource "elasticstack_elasticsearch_security_user" "xxx-write" {
  username = "xxx-write"

  password = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.xxx-write.id,
  ]
}
