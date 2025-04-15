terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "k8s_master" {
  name        = "k8s-master"
  target_node = var.pm_node
  clone       = var.template_name
  full_clone  = true
  cores       = 2
  memory      = 2048
  sockets     = 1
  disk {
    size    = "20G"
    type    = "scsi"
    storage = var.vm_storage
  }

  network {
    model  = "virtio"
    bridge = var.network_bridge
  }

  sshkeys   = file(var.ssh_public_key_path)
  ciuser    = "ubuntu"
  ipconfig0 = "ip=192.168.10.100/24,gw=${var.gateway}"
}

resource "proxmox_vm_qemu" "k8s_workers" {
  count       = 3
  name        = "k8s-worker-${count.index}"
  target_node = var.pm_node
  clone       = var.template_name
  full_clone  = true
  cores       = 2
  memory      = 2048
  sockets     = 1
  disk {
    size    = "20G"
    type    = "scsi"
    storage = var.vm_storage
  }

  network {
    model  = "virtio"
    bridge = var.network_bridge
  }

  sshkeys   = file(var.ssh_public_key_path)
  ciuser    = "ubuntu"
  ipconfig0 = "ip=192.168.10.${count.index + 101}/24,gw=${var.gateway}"
}
