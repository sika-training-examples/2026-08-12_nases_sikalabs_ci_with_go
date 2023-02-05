terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.30.0"
    }
  }
}

provider "grafana" {
  url = "https://simple-grafana.k8s.sikademo.com"
  # url = "http://127.0.0.1:3000"
  auth = "admin:admin"
}

resource "grafana_data_source" "prometheus-internal" {
  type = "prometheus"
  name = "Internal Prometheus"
  url  = "http://prometheus-stack-prometheus.prometheus-stack:9090/"
  uid  = "prometheus-internal"
}

resource "grafana_data_source" "prometheus-external" {
  type = "prometheus"
  name = "External Prometheus"
  url  = "http://prom.sikademo.com:9090/"
  uid  = "prometheus-external"
}

resource "grafana_data_source" "loki-internal" {
  type = "loki"
  name = "Internal Loki"
  url  = "http://loki-read.loki:3100/"
  uid  = "loki-internal"
}

resource "grafana_dashboard" "example" {
  config_json = file("./dashboards/example.json")
}

resource "grafana_dashboard" "metgen" {
  config_json = file("./dashboards/metgen_v3.json")
}

resource "grafana_dashboard" "loki" {
  config_json = file("./dashboards/loki_v1.json")
}
