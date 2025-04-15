output "k8s_master_ip" {
  value = "192.168.10.100"
}

output "k8s_worker_ips" {
  value = [for i in range(3) : "192.168.10.${i + 101}"]
}
