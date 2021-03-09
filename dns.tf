# Create a GCP dns record to go along with the instance
resource "google_dns_record_set" "main" {
  count = var.enable_google_dns == true ? var.hostnames[count.index] : 0
  name  = maas_instance.main[count.index].hostname
  type  = A
  ttl   = var.dns_ttl

  managed_zone = var.dns_zone

  rrdatas = maas_instance.main[count.index].ipaddresses
}
