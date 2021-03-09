# Setup cloud-init template
data "template_file" "cloudinit" {
  count    = local.instance_count
  template = file("${path.module}/templates/cloud_init.tpl")

  vars = {
    hostname = var.hostnames[count.index]
  }
}
