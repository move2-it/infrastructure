module "promtail" {
  source = "../../modules/promtail"

  lokiRemoteUrl = "https://<user>:<password>@<host>/loki/api/v1/push"
}