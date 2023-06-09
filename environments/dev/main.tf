data "akeyless_static_secret" "promtail_remote_url" {
  path = "promtail/remote_url"
}

data "akeyless_static_secret" "prometheus_remote_url" {
  path = "prometheus/remote_url"
}

data "akeyless_static_secret" "prometheus_remote_username" {
  path = "prometheus/remote_username"
}

data "akeyless_static_secret" "prometheus_remote_password" {
  path = "prometheus/remote_password"
}

data "akeyless_static_secret" "rabbitmq_endpoint" {
  path = "rabbitmq/endpoint"
}

data "akeyless_static_secret" "rabbitmq_username" {
  path = "rabbitmq/username"
}

data "akeyless_static_secret" "rabbitmq_password" {
  path = "rabbitmq/password"
}

module "promtail" {
  source = "../../modules/promtail"

  lokiRemoteUrl = data.akeyless_static_secret.promtail_remote_url.value
}

module "prometheus" {
  source = "../../modules/prometheus"

  prometheusRemoteUrl      = data.akeyless_static_secret.prometheus_remote_url.value
  prometheusRemoteUsername = data.akeyless_static_secret.prometheus_remote_username.value
  prometheusRemotePassword = data.akeyless_static_secret.prometheus_remote_password.value
}

module "rabbitmq" {
  source = "../../modules/rabbitmq"

  endpoint = data.akeyless_static_secret.rabbitmq_endpoint.value
  password = data.akeyless_static_secret.rabbitmq_password.value
  username = data.akeyless_static_secret.rabbitmq_username.value
}