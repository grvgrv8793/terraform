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
  count   = 2
  length  = 4
  special = false
  upper   = false
}


resource "docker_container" "nodered_container" {
  count = 2
  name  = join("-", ["nodered_app", random_string.random1[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
  }
}


output "IP-Address1" {
  value       = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external])
  description = "IP address of container"
}

output "Container-name1" {
  value       = docker_container.nodered_container[0].name
  description = "the name of conatiner"
}

output "IP-Address2" {
  value       = join(":", [docker_container.nodered_container[1].ip_address, docker_container.nodered_container[1].ports[0].external])
  description = "IP address of container"
}

output "Container-name-2" {
  value       = docker_container.nodered_container[1].name
  description = "the name of conatiner"
}
