variable "ext_port" {
  type = list(any)

  # validation {
  #   condition     = var.ext_port <= 65535 && var.ext_port > 0
  #   error_message = "The external port should be in range 0 - 65535."
  # }
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
  container_count = length(var.ext_port)
}