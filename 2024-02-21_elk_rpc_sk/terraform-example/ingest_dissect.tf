data "elasticstack_elasticsearch_ingest_processor_dissect" "dissect" {
  field   = "message"
  pattern = "%%{prefix} %%{date} %%{time} %%{level} %%{message} (i=%%{i|integer})"
}

data "elasticstack_elasticsearch_ingest_processor_append" "ok" {
  field = "tags"
  value = ["ingest_dissect_ok"]
}

data "elasticstack_elasticsearch_ingest_processor_append" "err" {
  field = "tags"
  value = ["ingest_dissect_err"]
}


resource "elasticstack_elasticsearch_ingest_pipeline" "dissect" {
  name = "a_dissect"

  processors = [
    data.elasticstack_elasticsearch_ingest_processor_dissect.dissect.json,
    data.elasticstack_elasticsearch_ingest_processor_append.ok.json,
  ]
  on_failure = [
    data.elasticstack_elasticsearch_ingest_processor_append.err.json,
  ]
}
