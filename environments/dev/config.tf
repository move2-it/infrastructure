terraform {
  required_providers {
    akeyless = {
      source  = "akeyless-community/akeyless"
      version = "1.1.15"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.7.1"
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
    config_path = "~/.kube/config"
  }
}