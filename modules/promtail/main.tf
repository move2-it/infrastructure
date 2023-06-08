terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }
  }
}

resource "helm_release" "this" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "6.11.3"

  set_sensitive {
    name  = "config.clients[0].url"
    value = var.lokiRemoteUrl
  }
}