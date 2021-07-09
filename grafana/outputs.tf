output "server_public_ip" {
    value = module.instances.server_public_ip  
}

output "loadbalancer_ip" {
    value = module.instances.loadbalancer_ip
}