locals {
  prefix   = "m-ondrejsika"
  location = "westeurope"
  common_tags = {
    with_modules = "yes"
    account      = "asseco-ce"
    team         = "asseco-infra-net-sk"
    created_at   = timestamp()
  }

  # VM
  size       = "Standard_B1ls" // 1 CPU, 0.5 RAM https://cloudprice.net/vm/Standard_B1ls
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmPePobYm8Pl/V6OscZSYR3iDoAs9tVLBCCC2RpK/rRLzlTa5SqqdviWXLaNDSURRq1InKDNZs8UBcEzX6W00uV89ekXkhYf+TW2dIL/SeLQ2zIF7qX387J/A8+H6QtQX4DMzrz7xkWld3oDbC8Tol5sEpsQRFwW781Q8Zf6ZAA+eeN6kBUsii3iYJ736iDI8zHHOBofDn07jMNjEkNFRMoblmBwpqcfLXDjnolvtGSeIL9wede2bDQ0QKUPkanTXoNcHVEkGGGITmgAu6TZtRUXu2ESWF4toUPQ5Jznhi819IbapUYy6UAnS61b3jN2+VgKTHetuikr/Wni5IrvvvBVfBWGlQ37WHP+8JjM/7F9oNJ8bWIyICb3CGxr5py/E5SDPqZl8gz4I1hHaFCfP9bkyb+iMp60dWbG1jfdBOJeC+8TTkt3aHQv206gY7mSofzDn4zSvSM3alcqK8IVoQBiYWFJiqgwOfybOHM9kOEt66jB/KUNhaf/3hQMA0OZE= root@lab0"

  vm_network_security_group_ids = [
    azurerm_network_security_group.allow22.id,
  ]
}
