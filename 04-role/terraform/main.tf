terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

resource "yandex_vpc_network" "network" {
  name = "network"
}
resource "yandex_vpc_subnet" "subnet" {
  name = "subnet"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.subnet_cidr]
}

data "yandex_compute_image" "image" {
  family = var.os_image
}

resource "yandex_compute_instance" "vm" {
  for_each    = { for k, v in var.vm_spec : k => v }
  name        = each.value.vm_name
  hostname    = each.value.vm_name
  platform_id = var.vm_platform
  scheduling_policy {
    preemptible = var.test_mode
  }
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.test_mode ? 5 : 100
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      size     = each.value.disk
    }
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet.id
    ip_address = cidrhost(var.subnet_cidr, each.key + 101)
    nat        = true
  }
  metadata = {
    ssh-keys = "${var.os_user}:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "local_file" "inventory" {
  filename = "../playbook/inventory/prod.yml"
  content = templatefile("./inventory.tftpl", {
    vms = values(yandex_compute_instance.vm)[*]
  })
}
