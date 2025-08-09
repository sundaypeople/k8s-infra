terraform {
  required_providers {
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "2.26.0"
    }
  }
}
provider "sakuracloud" {
  profile = "default"
}