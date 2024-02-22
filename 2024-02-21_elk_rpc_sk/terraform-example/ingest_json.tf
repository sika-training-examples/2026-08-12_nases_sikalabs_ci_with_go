resource "elasticstack_elasticsearch_ingest_pipeline" "a_json" {
  name        = "a_json"
  description = "My first ingest pipeline managed by Terraform"

  processors = [
    <<EOF
      {
        "json": {
          "field": "message",
          "add_to_root": true
        }
      }
    EOF
    ,
    <<EOF
      {
        "append": {
          "field": "tags",
          "value": [
            "ingest_json_ok"
          ]
        }
      }
    EOF
  ]
  on_failure = [
    <<EOF
      {
        "append": {
          "field": "tags",
          "value": [
            "ingest_json_error"
          ]
        }
      }
    EOF
  ]
}
