module "vm1" {
  name          = "vm1"
  source        = "./modules/instance"
  vpc_subnet_id = yandex_vpc_subnet.subnet1.id
  username      = var.username
}

resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# Генерируем шаблон inventory
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.ini.tpl")
  vars = {
    vm1_ip = module.vm1.external_ip_address_vm
    user   = var.username
  }
}

# Записываем сгенерированный шаблон в файл
resource "null_resource" "update_inventory" {
  triggers = { # Код будет выполнен, когда inventory будет сгенерирован
    template = data.template_file.ansible_inventory.rendered
  }
  provisioner "local-exec" { # выполняем команду на локальной машине
    command = "echo '${data.template_file.ansible_inventory.rendered}' > ../ansible/inventory.ini"
  }
}

# Генерируем шаблон variables
data "template_file" "ansible_variables" {
  template = file("${path.module}/variables.yml.tpl")
  vars = {
    user   = var.username
  }
}

# Записываем сгенерированный шаблон в файл
resource "null_resource" "update_variables" {
  triggers = { # Код будет выполнен, когда variables будет сгенерирован
    template = data.template_file.ansible_variables.rendered
  }
  provisioner "local-exec" { # выполняем команду на локальной машине
    command = "echo '${data.template_file.ansible_variables.rendered}' > ../ansible/variables.yml"
  }
}