output "vm_names" {
  value = virtualbox_vm.k8s_nodes[*].name
}