data "akeyless_static_secret" "rabbitmq_endpoint" {
  path = "rabbitmq/endpoint"
}

data "akeyless_static_secret" "rabbitmq_username" {
  path = "rabbitmq/username"
}

data "akeyless_static_secret" "rabbitmq_password" {
  path = "rabbitmq/password"
}

data "akeyless_static_secret" "render_email" {
  path = "render/email"
}

data "akeyless_static_secret" "render_password" {
  path = "render/password"
}

data "akeyless_static_secret" "render_userId" {
  path = "render/userId"
}

module "rabbitmq" {
  source = "../../modules/rabbitmq"

  endpoint = data.akeyless_static_secret.rabbitmq_endpoint.value
  password = data.akeyless_static_secret.rabbitmq_password.value
  username = data.akeyless_static_secret.rabbitmq_username.value
}

module "application" {
  source = "../../modules/application"

  email = data.akeyless_static_secret.render_email.value
  password = data.akeyless_static_secret.render_password.value
  userId = data.akeyless_static_secret.render_userId.value

  name = "agent"
  dockerImageUrl = "docker.io/library/nginx:latest"
}