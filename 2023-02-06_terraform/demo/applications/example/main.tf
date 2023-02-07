module "vm--db" {
  source = "../../modules/vm"
  count  = var.db_count

  name     = "${var.prefix}-db-${count.index}"
  zone_id  = var.zone_id
  ssh_keys = var.ssh_keys
}

module "vms" {
  source   = "../../modules/vm"
  for_each = var.vms

  name     = "${var.prefix}-${each.key}"
  size     = each.value.size
  zone_id  = var.zone_id
  ssh_keys = var.ssh_keys
}

output "dbs" {
  value = {
    for vm in module.vm--db :
    vm.name => {
      ip     = vm.ip
      domain = vm.domain
    }
  }
}

output "vms" {
  value = {
    for vm in module.vms :
    vm.name => {
      ip     = vm.ip
      domain = vm.domain
    }
  }
}

output "ansible-hosts" {
  value = {
    dbs = {
      hosts = [for vm in module.vm--db : vm.ip]
    }
    vms = {
      hosts = [for vm in module.vms : vm.ip]
    }
  }
}
