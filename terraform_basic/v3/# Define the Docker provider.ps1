# Define the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Define the Docker network
resource "docker_network" "mongo-network" {
  name   = "mongo-network"
  driver = "bridge"
}

# Define the MongoDB image
resource "docker_image" "mongo" {
  name = "mongo:latest"
}

# Define the Mongo-express image
resource "docker_image" "mongo-express" {
  name = "mongo-express:latest"
}

# Define the MongoDB container
resource "docker_container" "mongo" {
  name  = "mongo"
  image = docker_image.mongo.latest
  networks_advanced {
    name    = docker_network.mongo-network.name
    aliases = ["mongo"]
  }
  restart = "unless-stopped"
  destroy_grace_seconds = 30
  must_run = true
  memory = 256
  volumes {
    host_path      = "/data/db"
    container_path = "/data/db"
  }
  # Set environment variables for the root user, password, and database name
  env = [
    "MONGO_INITDB_ROOT_USERNAME=devroot",
    "MONGO_INITDB_ROOT_PASSWORD=devroot",
    "MONGO_INITDB_DATABASE=project"
  ]
  # Expose the default port
  ports {
    internal = 27017
    external = 27017
    ip       = "0.0.0.0"
  }
}

# Define the Mongo-express container
resource "docker_container" "mongo-express" {
  name  = "mongo-express"
  image = docker_image.mongo-express.latest
  networks_advanced {
    name    = docker_network.mongo-network.name
    aliases = ["mongo-express"]
  }
  restart = "unless-stopped"
  destroy_grace_seconds = 30
  must_run = true
  memory = 256
  # Set environment variables for the MongoDB connection
  env = [
    "ME_CONFIG_MONGODB_SERVER=mongo",
    "ME_CONFIG_MONGODB_PORT=27017",
    "ME_CONFIG_MONGODB_ENABLE_ADMIN=false",
    "ME_CONFIG_MONGODB_AUTH_DATABASE=admin",
    "ME_CONFIG_MONGODB_AUTH_USERNAME=devroot",
    "ME_CONFIG_MONGODB_AUTH_PASSWORD=devroot",
    # Set environment variables for the basic authentication and port
    "ME_CONFIG_BASICAUTH_USERNAME=dev",
    "ME_CONFIG_BASICAUTH_PASSWORD=dev",
    "ME_CONFIG_MONGODB_PORT=8081"
  ]
  # Expose the port
  ports {
    internal = 8081
    external = 8081
    ip       = "0.0.0.0"
  }
}

# Define the outputs
output "mongo_container_name" {
  value = docker_container.mongo.name
}

output "mongo_express_container_name" {
  value = docker_container.mongo-express.name
}

output "mongo_express_url" {
  value = "http://localhost:8081"
}
