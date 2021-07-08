data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
       name = "name"
       values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210430"]
       #values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}


resource "aws_instance" "grafana-web-server-instance" {
  #ubuntu #'3micro free tier
    ami = data.aws_ami.ubuntu.id #ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    availability_zone = var.availability_zone
   # instance_count = var.instance_count Find out alternative?
    
    network_interface {
        device_index = 0
        network_interface_id = var.grafana_interface
    }

    user_data = <<-EOF
                 #!/bin/bash
                 sudo apt update -y
                 sudo apt-get install -y apt-transport-https
                 sudo apt-get install -y software-properties-common wget
                 sudo snap install grafana
                 sudo start grafana
                 EOF
    
    tags = {
        Name = "grafana-web-server"
    }
}

resource "aws_eip" "one" {
    vpc = true
    network_interface = var.grafana_interface
    associate_with_private_ip = "172.20.100.50"
}

#9 Lets go ahead and create a second elastic IP for the load balancer

resource "aws_eip" "two" {
    vpc = true
}

#11 setup the load balancer

resource "aws_lb" "loadbalancer" {
    name = "network-loadbalancer"
    load_balancer_type = "network"

    subnet_mapping {
        subnet_id = var.grafana_subnet
        allocation_id = aws_eip.two.id
    }

    internal = false
}

#12 load balancer listener

resource "aws_lb_listener" "grafana_loadbalancer_listener" {
    port    = 80
    protocol = "TCP"

    load_balancer_arn = aws_lb.loadbalancer.arn

    default_action {
        type    = "forward"
        target_group_arn    = aws_lb_target_group.target_group.arn
    }
}

#13 load balancer target group

resource "aws_lb_target_group" "target_group" {
    port = 80
    protocol = "TCP"
    vpc_id = var.grafana-prod
    target_type = "ip"
}

#14 attach the aws instance to the target group

resource "aws_lb_target_group_attachment" "group" {
    target_group_arn = aws_lb_target_group.target_group.arn
    target_id = aws_instance.grafana-web-server-instance.private_ip
    port = 3000
    availability_zone = var.availability_zone
}

#output IP's





#resource "aws_network_interface" "private_grafana_interface" {
#    subnet_id = var.grafana_subnet
#    private_ips = ["172.20.100.50"]
#    security_groups = [var.allow-web]
#}
