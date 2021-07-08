output "grafana_interface" {
  value = aws_network_interface.private_grafana_interface.id
}

output "grafana_subnet" {
    value = aws_subnet.grafana-subnet.id
}

output "grafana-prod" {
    value = aws_vpc.grafana-prod.id
}

output "allow-web" {
    value = aws_security_group.allow-web.id
}