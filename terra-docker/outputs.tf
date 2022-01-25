output "Container-name" {
  value       = docker_container.nodered_container[*].name // Here * is a splat operator used for looping
  description = "the name of conatiner"
}

output "IP-Address" { // This is how we use for loop, here we are ittrating over container and fetching values
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
  description = "IP address of container"
}