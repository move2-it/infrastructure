terraform {
  required_providers {
    akeyless = {
      source  = "akeyless-community/akeyless"
      version = "1.3.0"
    }
  }

  cloud {
    organization = "move2-it"

    workspaces {
      name = "move2-it"
    }
  }
}

provider "akeyless" {
  api_gateway_address = var.akeyless_api_gateway_address

  api_key_login {
    access_id  = var.akeyless_access_id
    access_key = var.akeyless_access_key
  }
}

provider "helm" {
  kubernetes {
    host = var.kubernetes_url
    insecure = true
  }
}