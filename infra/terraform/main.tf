resource "null_resource" "vagrant_up" {
  provisioner "local-exec" {
    command = "vagrant up"
  }

}

# ---------------------------
# Trigger Vagrant Destroy
# ---------------------------
resource "null_resource" "vagrant_destroy" {
  provisioner "local-exec" {
    when    = destroy
    command = "vagrant destroy -f"
  }
}