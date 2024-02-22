resource "elasticstack_elasticsearch_security_user" "foo" {
  username = "foo"
  password = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.demo_read.id,
    elasticstack_kibana_security_role.foo_read.id
  ]
}

resource "elasticstack_elasticsearch_security_user" "aaa" {
  username = "aaa"
  password = "asdfasdf"
  roles = [
    elasticstack_kibana_security_role.foo_read.id
  ]
}
