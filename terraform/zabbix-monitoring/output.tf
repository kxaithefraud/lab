output "zabbix_public_ip" {
  value = hcloud_server.zabbix.ipv4_address
}

output "zabbix_private_ip" {
  value = "10.0.1.10"
}