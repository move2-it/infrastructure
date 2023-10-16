module "application" {
  source = "../../external_modules/render"

  email = var.email
  password = var.password
  userId = var.userId

  name = var.name
  dockerImageUrl = var.dockerImageUrl
}