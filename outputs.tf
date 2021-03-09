output "instance" {
  count = length(maas_instance.main)
  value = [
    {
      metadata     = maas_instance.main[count.index]
      ip_addresses = var.enable_google_dns == true ? google_dns_record_set.main[count.index].rrdatas : nil
    }
  ]
}
