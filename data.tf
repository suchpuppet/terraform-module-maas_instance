# Setup cloud-init template
data "template_file" "cloudinit" {
  count    = length(var.hosts)
  template = file("${path.module}/templates/cloud_init.tpl")

  vars = {
    hostname = var.hosts[count.index]["hostname"]
    ssh_authorized_key = var.ssh_authorized_key
  }
}
