variable "hcloud_token" {
  type        = string
  description = "Hetzner Cloud API token"
  sensitive   = true
}

variable "server_type" {
  type        = string
  default     = "cx22"
}

variable "server_image" {
  type        = string
  default     = "ubuntu-24.04"
}

variable "server_location" {
  type        = string
  default     = "nbg1"
}

variable "ssh_public_key_path" {
  type        = string
  default     = "hetzner-server.pub"
}

variable "private_network_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR range for the private network"
}

variable "network_zone" {
  type        = string
  default     = "eu-central"
  description = "Hetzner Cloud network zone"
}