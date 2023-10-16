terraform {
  required_providers {
    graphql = {
      source  = "sullivtr/graphql"
      version = "2.5.4"
    }
  }
}

provider "graphql" {
  url = "https://api.render.com/graphql"

  oauth2_login_query           = file("${path.module}/graphql/login.graphql")
  oauth2_login_query_variables = {
    "email"    = var.email
    "password" = var.password
  }
  oauth2_login_query_value_attribute = "data.signIn.idToken"
}

resource "graphql_mutation" "basic_mutation" {
  mutation_variables = {
    "server" = jsonencode({
      "autoDeploy" : true,
      "baseDir" : "",
      "branch" : "",
      "buildCommand" : "",
      "name" : var.name,
      "dockerfilePath" : "",
      "dockerCommand" : "",
      "envId" : "image",
      "envVars" : [],
      "healthCheckPath" : "",
      "ownerId" : var.userId,
      "plan" : "Free",
      "repo" : null,
      "externalImage" : {
        "imageURL" : var.dockerImageUrl,
        "ownerID" : var.userId,
        "registryCredentialID" : null
      },
      "isWorker" : false,
      "isPrivate" : false,
      "region" : "frankfurt",
      "startCommand" : "",
      "staticPublishPath" : "",
      "rootDir" : "",
      "buildFilter" : {
        "paths" : [],
        "ignoredPaths" : []
      },
      "preDeployCommand" : null,
      "environmentId" : null
    })
  }

  compute_from_create = true

  compute_mutation_keys = {
    "id" = "data.createServer.id"
  }

  create_mutation = file("${path.module}/graphql/createMutation.graphql")
  update_mutation = file("${path.module}/graphql/readQuery.graphql") // Update is not available
  delete_mutation = file("${path.module}/graphql/deleteMutation.graphql")
  read_query      = file("${path.module}/graphql/readQuery.graphql")
}