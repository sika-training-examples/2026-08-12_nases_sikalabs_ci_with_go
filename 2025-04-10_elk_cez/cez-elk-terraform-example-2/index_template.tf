resource "elasticstack_elasticsearch_index_lifecycle" "max_10_docs" {
  name = "max_10_docs"

  hot {
    rollover {
      max_docs = 10
    }
    readonly {}
  }

  delete {
    min_age = "5m"
    delete {}
  }
}

resource "elasticstack_elasticsearch_index_template" "xxx" {
  name           = "xxx"
  index_patterns = ["xxx*"]
  data_stream {}
  template {
    settings = jsonencode({
      "lifecycle.name" = elasticstack_elasticsearch_index_lifecycle.max_10_docs.name
    })
  }
}
