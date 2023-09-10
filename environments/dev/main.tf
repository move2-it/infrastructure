data "akeyless_static_secret" "rabbitmq_endpoint" {
  path = "rabbitmq/endpoint"
}

data "akeyless_static_secret" "rabbitmq_username" {
  path = "rabbitmq/username"
}

data "akeyless_static_secret" "rabbitmq_password" {
  path = "rabbitmq/password"
}

module "rabbitmq" {
  source = "../../modules/rabbitmq"

  endpoint = data.akeyless_static_secret.rabbitmq_endpoint.value
  password = data.akeyless_static_secret.rabbitmq_password.value
  username = data.akeyless_static_secret.rabbitmq_username.value
}