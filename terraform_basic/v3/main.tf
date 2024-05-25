terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.21.0"
    }
  }
}

provider "docker" {}

# Define a Docker network
resource "docker_network" "mongo_network" {
  name = "mongo_network"
}

# Define MongoDB container resource
resource "docker_container" "mongo" {
  name  = "mongo"
  image = "mongo:latest"

  ports {
    internal = 27017
    external = 27017
  }
  # Use the command argument to set environment variables
  command = ["--auth", "--port", "27017", "--bind_ip_all", "--username", "admin", "--password", "admin"]

  # Attach the container to the user-defined network
  network_mode = docker_network.mongo_network.name
}

# Define MongoDB Express container resource

resource "docker_container" "mongo_express" {
  name  = "mongo-express"
  image = "mongo-express:latest"

  ports {
    internal = 8081
    external = 8081
  }

  # Attach the container to the user-defined network
  network_mode = docker_network.mongo_network.name
}

