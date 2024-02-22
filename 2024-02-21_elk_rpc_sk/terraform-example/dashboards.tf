resource "null_resource" "example_dashboard" {
  for_each = toset([
    elasticstack_kibana_space.demo.id,
    elasticstack_kibana_space.foo.id,
  ])

  provisioner "local-exec" {
    command = "curl -X POST -u ${var.elasticsearch_user}:${var.elasticsearch_password} ${var.kibana_endpoint}/s/${each.key}/api/saved_objects/_import?overwrite=true -H \"kbn-xsrf: true\" --form file=@dashboards/example.ndjson"
  }
  triggers = {
    dashboardq_sha1 = "${sha1(file("./dashboards/example.ndjson"))}"
  }
}
