resource "null_resource" "foo" {
  for_each = {
    foo = {
      aaa = 1
      bbb = 2
    }
  }
}

resource "null_resource" "foo2" {
  name = "foo"
  aaa  = 1
  bbb  = 2
}

resource "null_resource" "foo3" {
  config = {
    name = "foo"
    aaa  = 1
    bbb  = 2
  }
}
