output "vm_names" {
  value = [for i in range(var.vm_count) : "k8s-node-${i + 1}"]
}

output "vm_ips" {
  value = [for i in range(var.vm_count) : "192.168.56.${10 + i}"]
}