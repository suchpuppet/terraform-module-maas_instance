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

resource "maas_interface_physical" "main" {
  count       = length(var.hosts)
  system_id   = maas_instance.main[count.index].id
  mac_address = var.hosts[count.index]["mac_address"]
  vlan        = var.vlan
  depends_on  = [maas_instance.main]
}

resource "maas_interface_link" "main" {
  count        = length(var.hosts)
  system_id    = maas_instance.main[count.index].id
  interface_id = maas_interface_physical.main[count.index].id
  subnet_id    = var.subnet_id
  mode         = "STATIC"
  ip_address   = var.hosts[count.index]["ip_addresses"][0]
  depends_on   = [maas_interface_physical.main]
}
