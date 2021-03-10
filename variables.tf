variable "hosts" {
  type = list(any)
}

variable "distro" {
  type    = string
  default = "focal"
}

variable "release_erase" {
  type    = bool
  default = false
}

variable "user_data" {
  type    = string
  default = ""
}

variable "install_kvm" {
  type    = bool
  default = false
}

variable "dns_ttl" {
  type    = number
  default = 300
}

variable "dns_zone" {
  type = string
}

variable "enable_google_dns" {
  type    = bool
  default = true
}

variable "vlan" {
  type    = string
  default = "Default VLAN"
}

variable "subnet_id" {
  type    = number
  default = 1
}

variable "ssh_authorized_key" {
  type = string
}
