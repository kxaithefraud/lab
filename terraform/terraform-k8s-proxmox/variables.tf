variable "pm_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "pm_user" {
  description = "Proxmox username (e.g. root@pam)"
  type        = string
}

variable "pm_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "pm_node" {
  description = "Proxmox node name"
  type        = string
  default     = "Charon"
}

variable "template_name" {
  description = "Name of the cloud-init VM template to clone"
  type        = string
  default     = "ubuntu-cloudinit-template"
}

variable "vm_storage" {
  description = "Proxmox storage pool to use (e.g. local-lvm)"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Proxmox network bridge (e.g. vmbr0)"
  type        = string
  default     = "vmbr0"
}

variable "gateway" {
  description = "Gateway for the static IPs"
  type        = string
  default     = "192.168.10.1"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
