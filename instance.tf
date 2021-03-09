resource "maas_instance" "main" {
  count         = length(var.hostnames)
  hostname      = var.hostnames[count.index]
  user_data     = var.user_data == "" ? data.template_file.cloudinit[count.index].rendered : var.user_data
  distro_series = var.distro
  release_erase = var.release_erase
  storage       = var.disk_size
  install_kvm   = var.install_kvm

  lifecycle {
    ignore_changes = [user_data]
  }
}
