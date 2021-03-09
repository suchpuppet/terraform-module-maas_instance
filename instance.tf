resource "maas_instance" "main" {
  count         = length(var.hosts)
  hostname      = var.hosts[count.index]["hostname"]
  user_data     = var.user_data == "" ? data.template_file.cloudinit[count.index].rendered : var.user_data
  distro_series = var.distro
  release_erase = var.release_erase
  storage       = var.disk_size
  install_kvm   = var.install_kvm

  lifecycle {
    ignore_changes = [user_data]
  }
}
