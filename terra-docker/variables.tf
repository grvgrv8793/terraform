variable "env" {
  type        = string
  default     = "dev"
  description = "Env to Deploy"
}

// This is how we defaine map variable and for accessing/retriving value of maps we use lookup function

variable "image" {
  type        = map(any)
  description = "Image for container"
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "ext_port" {
  type = map(any)

  // Lookup function dont work under validation block

  validation {
    condition = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
    // This is how we use max and min function with list of variables, Also ... is an expand/spread operator similar to JS
    error_message = "The external port should be in range 0 - 65535."
  }
  validation {
    condition = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
    // This is how we use max and min function with list of variables, Also ... is an expand/spread operator similar to JS
    error_message = "The external port should be in range 0 - 65535."
  }
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port <= 65535 && var.int_port > 0
    error_message = "The external port should be in range 0 - 65535."
  }
}

locals {
  container_count = length(lookup(var.ext_port, var.env))
  // Adding lookup as we changed external to maps
}