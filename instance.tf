resource "maas_instance" "main" {
  count         = length(var.hosts)
  hostname      = var.hosts[count.index]["hostname"]
  user_data     = var.user_data == "" ? data.template_file.cloudinit[count.index].rendered : var.user_data
  distro_series = var.distro
  release_erase = var.release_erase
  install_kvm   = var.install_kvm
  ip_addresses  = var.hosts[count.index]["ip_addresses"]

  lifecycle {
    ignore_changes = [user_data]
  }
}

# AWX-driven Ansible Provisioning
resource "null_resource" "provision_ansible_maas" {
  # Enable this resource if awx provisioning is desired
  count = var.awx_provisioning == false ? 0 : 1

  # Changes to any instance in the cluster requires re-provisioning
  triggers = {
    maas_instance_ids = join(",", maas_instance.main.*.id)
  }

  # Kick off the AWX Job Template now that the host is up
  provisioner "local-exec" {
    command = <<-AWX
    curl -L --user ${var.awx_user}:${var.awx_password} \
    -H 'Content-Type: application/json' \
    -X POST \
    -d '{"limit": ""${var.hosts[count.index]["hostname"]}""}' \
    "${var.awx_url}/api/v2/job_templates/${var.awx_job_template_id}/launch/"
    AWX
  }

  # The instance resources need to be created before we can provision them
  depends_on = [
    maas_instance.main
  ]
}
