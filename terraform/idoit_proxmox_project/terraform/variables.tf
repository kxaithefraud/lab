variable "proxmox_api_url" {
  type    = string
  default = "https://your-proxmox-host:8006/api2/json"
}

variable "proxmox_user" {
  type    = string
  default = "terraform@pve"
}

variable "proxmox_password" {
  type    = string
  default = "your-api-token"
}

variable "target_node" {
  type    = string
  default = "proxmox-node-name"
}

variable "template_name" {
  type    = string
  default = "Debian-12-Template"
}