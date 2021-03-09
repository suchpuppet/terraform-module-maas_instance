terraform {
  required_providers {
    maas = {
      source  = "suchpuppet/maas"
      version = "3.1.3"
    }
    google = {
      source  = "hashicorp/google"
      version = "3.59.0"
    }
  }
}
