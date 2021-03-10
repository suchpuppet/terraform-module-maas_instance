resource "maas_instance" "main" {
  count         = length(var.hosts)
  hostname      = var.hosts[count.index]["hostname"]
  user_data     = var.user_data == "" ? data.template_file.cloudinit[count.index].rendered : var.user_data
  distro_series = var.distro
  release_erase = var.release_erase
  install_kvm   = var.install_kvm
  ip_addresses  = var.hosts[count.index]["ip_addresses"]
  address       = var.hosts[count.index]["ip_addresses"][0]

  lifecycle {
    ignore_changes = [user_data]
  }
}
