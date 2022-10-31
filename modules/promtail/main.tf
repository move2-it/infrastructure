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
    lokiRemoteUrl = var.lokiRemoteUrl
  }
}

resource "helm_release" "this" {
  name       = "promtail"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "6.6.0"

  values = [
    data.template_file.this.rendered
  ]
}