
output "ansible-hosts" {
  value = {
    "all" : {
      "hosts" : ["vm101.sikademo.com", "vm102.sikademo.com"]
    }
  }
}
