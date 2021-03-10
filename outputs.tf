output "instance_metadata" {
  value = resource.maas_instance.main
}

output "interfaces" {
  value = [
    resource.maas_interface_physical.main,
    resource.maas_interface_link.main
  ]
}
