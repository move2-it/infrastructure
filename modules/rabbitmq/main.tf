terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "1.8.0"
    }
  }
}

provider "rabbitmq" {
  endpoint = var.endpoint
  username = var.username
  password = var.password
}

resource "rabbitmq_queue" "test" {
  name  = "test"
  vhost = var.username

  settings {
    durable = true
  }
}