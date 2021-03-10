output "instance_metadata" {
  value = resource.maas_instance.main[0]
}

output "interfaces" {
  value = [
    resource.maas_interface_physical.main[0],
    resource.maas_interface_link.main[0]
  ]
}
