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


output "Container-name" {
  value       = docker_container.nodered_container[*].name // Here * is a splat operator used for looping
  description = "the name of conatiner"
}

output "IP-Address" { // This is how we use for loop, here we are ittrating over container and fetching values
  value       = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address],i.ports[*]["external"])]
  description = "IP address of container"
}

