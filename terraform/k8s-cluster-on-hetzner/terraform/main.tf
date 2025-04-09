terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.50.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

# Upload your SSH public key to Hetzner
resource "hcloud_ssh_key" "default" {
  name       = "hetzner-key"
  public_key = file(var.ssh_public_key_path)
}

# Create a private network
resource "hcloud_network" "k8s_net" {
  name     = "k8s-network"
  ip_range = var.private_network_cidr
}

# Create a subnet for the private network
resource "hcloud_network_subnet" "k8s_subnet" {
  network_id   = hcloud_network.k8s_net.id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = var.private_network_cidr
}

# Master Node
resource "hcloud_server" "master" {
  name        = "Master-Node"
  server_type = var.server_type
  image       = var.server_image
  location    = var.server_location
  ssh_keys    = [hcloud_ssh_key.default.id]
  labels      = {
    role    = "master"
    project = "K8s"
  }

  network {
    network_id = hcloud_network.k8s_net.id
    ip         = "10.0.0.10"
  }
}

# Worker Nodes
resource "hcloud_server" "workers" {
  count       = 3
  name        = "Worker-Node-${count.index}"
  server_type = var.server_type
  image       = var.server_image
  location    = var.server_location
  ssh_keys    = [hcloud_ssh_key.default.id]
  labels      = {
    role    = "worker"
    project = "K8s"
  }

  network {
    network_id = hcloud_network.k8s_net.id
    ip         = "10.0.0.${count.index + 11}"
  }
}