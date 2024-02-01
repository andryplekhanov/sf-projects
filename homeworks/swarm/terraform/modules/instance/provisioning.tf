resource "null_resource" "docker-swarm-manager" {
  count = var.managers
  depends_on = [yandex_compute_instance.vm-manager]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.vm-manager[count.index].network_interface.0.nat_ip_address
  }

  provisioner "file" {
    source      = "../docker-compose/docker-compose-v3.yml"
    destination = "docker-compose.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh",
      "sudo usermod -aG docker $USER",
      "sudo docker swarm init",
      "sleep 10",
      "echo COMPLETED"
    ]
  }
}

resource "null_resource" "docker-swarm-manager-join" {
  count = var.managers
  depends_on = [yandex_compute_instance.vm-manager, null_resource.docker-swarm-manager]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.vm-manager[count.index].network_interface.0.nat_ip_address
  }

  provisioner "local-exec" {
    command = "TOKEN=$(ssh -i ${var.ssh_credentials.private_key} -o StrictHostKeyChecking=no ${var.ssh_credentials.user}@${yandex_compute_instance.vm-manager[count.index].network_interface.0.nat_ip_address} docker swarm join-token -q worker); echo \"#!/usr/bin/env bash\nsudo docker swarm join --token $TOKEN ${yandex_compute_instance.vm-manager[count.index].network_interface.0.nat_ip_address}:2377\nexit 0\" >| join.sh"
  }
}

resource "null_resource" "docker-swarm-worker" {
  count = var.workers
  depends_on = [yandex_compute_instance.vm-worker, null_resource.docker-swarm-manager-join]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.vm-worker[count.index].network_interface.0.nat_ip_address
  }

  provisioner "file" {
    source      = "join.sh"
    destination = "join.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done",
      "sudo curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh",
      "sudo usermod -aG docker $USER",
      "chmod +x join.sh",
      "./join.sh"
    ]
  }
}

resource "null_resource" "docker-swarm-manager-start" {
  depends_on = [yandex_compute_instance.vm-manager, null_resource.docker-swarm-manager-join]
  connection {
    user        = var.ssh_credentials.user
    private_key = file(var.ssh_credentials.private_key)
    host        = yandex_compute_instance.vm-manager[0].network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
        "docker stack deploy --compose-file ./docker-compose.yml sockshop-swarm"
    ]
  }

  provisioner "local-exec" {
    command = "rm join.sh"
  }
}