resource "elasticstack_kibana_import_saved_objects" "settings" {
  overwrite     = true
  space_id      = elasticstack_kibana_space.cez.space_id
  file_contents = file("dashboards/hello-cez.ndjson")
}
