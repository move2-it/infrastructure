module "promtail" {
  source = "../../modules/promtail"

  lokiRemoteUrl = "https://<user>:<password>@<host>/loki/api/v1/push"
}

module "prometheus" {
  source = "../../modules/prometheus"

  prometheusRemoteUrl = "https://<host>/api/prom/push"
  prometheusRemoteUsername = "<username>"
  prometheusRemotePassword = "<password>"
}