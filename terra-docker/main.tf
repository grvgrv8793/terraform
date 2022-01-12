terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "docker" {}
provider "random" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random1" {
  length  = 4
  special = false
  upper   = false
}

resource "random_string" "random2" {
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "nodered_container" {
  name  = join("-", ["nodered_app", random_string.random1.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
  }
}

resource "docker_container" "nodered_container2" {
  name  = join("-", ["nodered_app", random_string.random2.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
  }
}


output "IP-Address1" {
  value       = join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
  description = "IP address of container"
}

output "Container-name1" {
  value       = docker_container.nodered_container.name
  description = "the name of conatiner"
}

output "IP-Address2" {
  value       = join(":", [docker_container.nodered_container2.ip_address, docker_container.nodered_container.ports[0].external])
  description = "IP address of container"
}

output "Container-name-2" {
  value       = docker_container.nodered_container2.name
  description = "the name of conatiner"
}
