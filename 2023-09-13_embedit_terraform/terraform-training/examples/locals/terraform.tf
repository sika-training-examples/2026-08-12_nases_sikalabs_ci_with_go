locals {
  IMAGES = {
    DEBIAN = "debian-12-x64"
    CENTOS = "centos-8-x64"
  }
  SIZES = {
    CPU_1_MEM_2 = {
      AWS   = "t3.micro"
      AZURE = "Standard_B1ls"
    }
    CPU_2_MEM_4 = {
      AWS   = "c5.large"
      AZURE = "SuperFast"
    }
  }
}

locals {
  cloud = "AZURE"
}

output "vm" {
  value = local.IMAGES.DEBIAN
}

output "size" {
  value = local.SIZES.CPU_2_MEM_4[local.cloud]
}
