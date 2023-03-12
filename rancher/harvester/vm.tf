# Harvester infrastructure resources
data "harvester_image" "rancher" {
  name      = var.image_name
  namespace = var.image_namespace
}

data "harvester_network" "rancher" {
  name      = var.network_name
  namespace = var.network_namespace
}

resource "harvester_virtualmachine" "rancher_server" {
  name                 = "${var.prefix}-rancher-server"
  namespace            = var.namespace
  restart_after_update = true

  description = "Rancher server"

  cpu    = var.cpu_count
  memory = var.memory_size

  run_strategy = "RerunOnFailure"
  hostname     = "${var.prefix}-rancher-server"
  machine_type = "q35"

  ssh_keys = [
    harvester_ssh_key.vm_ssh_key.id
  ]

  network_interface {
    name           = "nic-1"
    network_name = data.harvester_network.rancher.id
    wait_for_lease = true
  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = var.disk_size
    bus        = "virtio"
    boot_order = 1

    image       = data.harvester_image.rancher.id
    auto_delete = true
  }

  cloudinit {
    user_data    = <<-EOF
      #cloud-config
      ssh_pwauth: true
      package_update: true
      packages:
        - qemu-guest-agent
      runcmd:
        - - systemctl
          - enable
          - '--now'
          - qemu-guest-agent
      ssh_authorized_keys:
        - ${harvester_ssh_key.vm_ssh_key.public_key}
      EOF
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.network_interface[0].ip_address
      user        = var.ssh_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# Install Rancher
module "rancher" {
  source = "../rancher"

  node_public_ip             = harvester_virtualmachine.rancher_server.network_interface[0].ip_address
  node_internal_ip           = harvester_virtualmachine.rancher_server.network_interface[0].ip_address
  ssh_private_key_pem        = tls_private_key.global_key.private_key_pem
  node_username              = var.ssh_username
  kubernetes_version         = var.kubernetes_version
  generated_files_dir = var.generated_files_dir

  cert_manager_version = var.cert_manager_version
  rancher_version      = var.rancher_version
  admin_password     = var.admin_password
  rancher_server_dns = join(".", ["rancher", harvester_virtualmachine.rancher_server.network_interface[0].ip_address, "sslip.io"])
}