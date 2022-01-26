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
  name = lookup(var.image, terraform.workspace)

  //Syntax: lookup(map,key,default)
  /// here we are using lookup function to access value of maps
}

resource "random_string" "random1" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}


resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered_app", terraform.workspace, random_string.random1[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.int_port
    external = lookup(var.ext_port, terraform.workspace)[count.index]
  }
}




