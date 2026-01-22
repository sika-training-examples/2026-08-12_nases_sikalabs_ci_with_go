locals {
  networks = {
    "01" = {
      name = "foo"
      id   = "aaa"
    }
    "02" = {
      name = "bar"
      id   = "bbb"
    }
    "03" = {
      name = "baz"
      id   = "ccc"
    }
  }
}

output "peerings" {
  value = merge([
    for key1, val1 in local.networks :
    {
      for key2, val2 in local.networks :
      "${key1}-${key2}" => {
        name = val1.name
        id   = val2.id
      } if key1 != key2
    }
  ]...)
}

