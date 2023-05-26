bootstrap_expect = 3
ui_config = {
  enabled = true
}
client_addr = "0.0.0.0"
datacenter = "fra"
data_dir = "/var/lib/consul"
enable_script_checks = true
dns_config = {
  enable_truncate = true
  only_passing = true
}
rejoin_after_leave = true
server = true
# node_name = "c-{{ .Vars.i }}"
bind_addr = "{{ .Vars.ip }}"
retry_join = [
  "c-fra-1.sikademo.com",
  "c-fra-2.sikademo.com",
  "c-fra-3.sikademo.com",
]
services = [
  {
    name = "node-exporter"
    port = 9100
    tags = ["prometheus"]
    check = {
      HTTP = "http://127.0.0.1:9100"
      interval = "10s"
      timeout = "1s"
    }
  }
]
