terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc8"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_user
  pm_password     = var.proxmox_password
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "idoit_vm" {
  name        = "idoit-server"
  target_node = var.target_node
  clone       = var.template_name
  cores       = 2
  memory      = 2048
  disk {
    slot    = "ide0"
    size    = "30G"
    type    = "disk"
    storage = "local-lvm-thin"
  }
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr2111"
  }
  #sshkeys = file("~/.ssh/id_rsa.pub")
  os_type = "cloud-init"
}