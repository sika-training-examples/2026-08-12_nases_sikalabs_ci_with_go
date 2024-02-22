resource "elasticstack_kibana_data_view" "sika-mac" {
  for_each = toset([
    "default",
    "main",
    elasticstack_kibana_space.demo.id,
    elasticstack_kibana_space.foo.id,
  ])

  space_id = each.key
  data_view = {
    name            = "sika-mac"
    title           = "sika-mac-*"
    time_field_name = "@timestamp"
  }
}

resource "elasticstack_kibana_data_view" "filebeat" {
  for_each = toset([
    "default",
    "main",
    elasticstack_kibana_space.demo.id,
    elasticstack_kibana_space.foo.id,
  ])

  space_id = each.key
  data_view = {
    name            = "afb"
    title           = "filebeat-*"
    time_field_name = "@timestamp"
  }
}

