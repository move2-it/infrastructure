terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }
  }
}

data "template_file" "this" {
  template = file("${path.module}/template/config.yml")

  vars = {
    prometheusRemoteUrl      = var.prometheusRemoteUrl
    prometheusRemoteUsername = var.prometheusRemoteUsername
    prometheusRemotePassword = var.prometheusRemotePassword
  }
}

resource "helm_release" "this" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "22.6.2"

  values = [
    data.template_file.this.rendered
  ]

  set_sensitive {
    name  = "server.remoteWrite[0].url"
    value = var.prometheusRemoteUrl
  }

  set_sensitive {
    name  = "server.remoteWrite[0].basic_auth.username"
    value = var.prometheusRemoteUsername
  }

  set_sensitive {
    name  = "server.remoteWrite[0].basic_auth.password"
    value = var.prometheusRemotePassword
  }
}