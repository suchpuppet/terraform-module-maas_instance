output "instance_metadata" {
  value = maas_instance.main
}

output "interfaces" {
  value = [
    maas_interface_physical.main,
    maas_interface_link.main
  ]
}
