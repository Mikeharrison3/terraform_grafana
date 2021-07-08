
resource "aws_vpc" "grafana-prod" {
    cidr_block = var.vpc_cidr_block
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.grafana-prod.id

    tags = {
        Name = "grafana-prod-gateway"
    }
}

resource "aws_route_table" "grafana-route-table" {
    vpc_id = aws_vpc.grafana-prod.id 

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

    tags = {
        Name = "grafana-route-table"
    }
}

resource "aws_subnet" "grafana-subnet" {
    vpc_id = aws_vpc.grafana-prod.id
    cidr_block = var.vpc_subnet

    availability_zone = var.availability_zone

    tags = {
        Name = "grafana-subnet"
    }
}

resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.grafana-subnet.id
    route_table_id = aws_route_table.grafana-route-table.id
}

resource "aws_security_group" "allow-web" {
    name = "allow-web"
    description = "Allow web access via port 3000 and possibly by ssh(future)"
    vpc_id = aws_vpc.grafana-prod.id

    ingress { 
        description = "Allow 3000 to grafana"
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Allow-web"
    }

}

resource "aws_network_interface" "private_grafana_interface" {
    subnet_id = aws_subnet.grafana-subnet.id
    private_ips = ["172.20.100.50"]
    security_groups = [aws_security_group.allow-web.id]
}
