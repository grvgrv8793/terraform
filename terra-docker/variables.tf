variable "ext_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.ext_port <= 65535 && var.ext_port > 0
    error_message = "The external port should be in range 0 - 65535."
  }
}

variable "int_port" {
  type = number
}

variable "container_count" {
  type    = number
  default = 2
}