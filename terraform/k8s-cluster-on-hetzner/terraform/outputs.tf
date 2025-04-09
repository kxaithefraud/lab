output "master_node_public_ip" {
  value = hcloud_server.master.ipv4_address
}

output "master_node_private_ip" {
  value = "10.0.0.10"
}

output "worker_node_public_ips" {
  value = [for s in hcloud_server.workers : s.ipv4_address]
}

output "worker_node_private_ips" {
  value = [for i in range(3) : "10.0.0.${i + 11}"]
}

output "ansible_inventory" {
  value = <<EOT
[master]
${hcloud_server.master.ipv4_address}

[workers]
%{ for s in hcloud_server.workers ~}
${s.ipv4_address}
%{ endfor }

[all:vars]
ansible_user=root
ansible_ssh_private_key_file=~/.ssh/hetzner-server
EOT
}