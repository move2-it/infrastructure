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

  oauth2_login_query           = "mutation signIn($email:String!,$password:String!){signIn(email:$email,password:$password){...authResultFields __typename}}fragment authResultFields on AuthResult{idToken expiresAt user{...userFields sudoModeExpiresAt __typename}readOnly __typename}fragment userFields on User{id active createdAt email featureFlags githubId gitlabId name notifyOnFail notifyOnPrUpdate otpEnabled passwordExists tosAcceptedAt intercomEmailHMAC __typename}"
  oauth2_login_query_variables = {
    "email"    = var.email
    "password" = var.password
  }
  oauth2_login_query_value_attribute = "data.signIn.idToken"
}

resource "graphql_mutation" "basic_mutation" {
  mutation_variables = {
    // Parametrize it
    "server" = jsonencode({
      "autoDeploy" : true,
      "baseDir" : "",
      "branch" : "",
      "buildCommand" : "",
      "name" : "test",
      "dockerfilePath" : "",
      "dockerCommand" : "",
      "envId" : "image",
      "envVars" : [],
      "healthCheckPath" : "",
      "ownerId" : "usr-123123123", // Input or fetch (?)
      "plan" : "Free",
      "repo" : null,
      "externalImage" : {
        "imageURL" : "docker.io/library/nginx:latest",
        "ownerID" : "usr-123123123",
        "registryCredentialID" : null
      },
      "isWorker" : false,
      "isPrivate" : false,
      "region" : "oregon",
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