# Create a GCP dns record to go along with the instance
resource "google_dns_record_set" "main" {
  count = var.enable_google_dns == true ? length(var.hosts) : 0
  name  = split(".", maas_instance.main[count.index].hostname)[0]
  type  = "A"
  ttl   = var.dns_ttl

  managed_zone = var.dns_zone

  rrdatas = [maas_instance.main[count.index].ip_addresses[0]]
}
