terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.7.1"
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
  version    = "15.17.0"

  values = [
    data.template_file.this.rendered
  ]
}