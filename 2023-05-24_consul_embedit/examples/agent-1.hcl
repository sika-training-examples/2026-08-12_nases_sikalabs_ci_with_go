services = {
  name = "bar"
  id = "bar-1"
  address = "127.0.0.1"
  port = 19002
  tags = ["web"]
  checks = {
    http = "http://127.0.0.1:19002/health"
    interval = "10s"
    timeout = "1s"
  }
}

services = {
  name = "bar"
  id = "bar-2"
  address = "127.0.0.1"
  port = 29002
  tags = ["web"]
  checks = {
    http = "http://127.0.0.1:29002/health"
    interval = "10s"
    timeout = "1s"
  }
}
