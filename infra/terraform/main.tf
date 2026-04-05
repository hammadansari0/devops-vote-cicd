provider "virtualbox" {}

variable "vm_count" {
  default = 3
}

resource "virtualbox_vm" "k8s_nodes" {
  count  = var.vm_count
  name   = "k8s-node-${count.index}"
  image  = "https://app.vagrantup.com/ubuntu/boxes/focal64/versions/20230801.0.0/providers/virtualbox.box"

  cpus   = 2
  memory = "2048 mib"

  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet0"
  }
}