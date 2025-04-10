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

resource "hcloud_ssh_key" "default" {
  name       = "hetzner-key"
  public_key = file(var.ssh_public_key_path)
}

resource "hcloud_network" "zabbix_net" {
  name     = "zabbix-network"
  ip_range = var.private_network_cidr
}

resource "hcloud_network_subnet" "zabbix_subnet" {
  network_id   = hcloud_network.zabbix_net.id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = var.private_network_cidr
}

resource "hcloud_server" "zabbix" {
  name        = "zabbix-server"
  server_type = var.server_type
  image       = var.server_image
  location    = var.server_location
  ssh_keys    = [hcloud_ssh_key.default.id]
  labels = {
    role    = "zabbix"
    project = "Monitoring"
  }

  network {
    network_id = hcloud_network.zabbix_net.id
    ip         = "10.0.1.10"
  }
}
resource "local_file" "ansible_inventory" {
  content  = <<EOF
[zabbix]
${hcloud_server.zabbix.ipv4_address} ansible_user=root
EOF
  filename = "${path.module}/inventory.ini"
}