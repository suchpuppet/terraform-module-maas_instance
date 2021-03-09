output "instance" {
  value = {
    metadata     = maas_instance.main
    ip_addresses = var.enable_google_dns == true ? google_dns_record_set.main.rrdatas : nil
  }
}
