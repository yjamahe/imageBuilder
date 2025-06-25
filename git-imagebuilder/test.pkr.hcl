# Default ARM64-based Unix/Linux test packer script.

variable project_id {
  type = string
  default = ""
}

variable target_image_name {
  type = string
  default = ""
}

variable target_image_encryption_key {
  type = string
  default = ""
}

variable zone {
  type = string
  default = ""
}

packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.6"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "imagebuilder" {
  project_id            = var.project_id
  source_image          = var.target_image_name
  zone                  = var.zone
  machine_type          = "c4a-standard-4"
  disk_type             = "hyperdisk-balanced"
  disk_size             = 50
  use_iap               = true
  skip_create_image     = true
  disk_encryption_key {
    kmsKeyName          = var.target_image_encryption_key
  }
  ssh_username            = "imagebuilder"
}

build {
  sources = ["sources.googlecompute.imagebuilder"]
}