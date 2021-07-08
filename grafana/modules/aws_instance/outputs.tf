output "server_public_ip" {
    value = aws_instance.grafana-web-server-instance.public_ip
}

output "loadbalancer_ip" {
    value = aws_eip.two.public_ip
}