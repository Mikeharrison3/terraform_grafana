terraform {
    required_providers {
      aws = {
          source = "hashicorp/aws"
      }
    }
}

provider "aws" {
    region = var.aws_region
}

data "aws_availability_zones" "available" {
    state = "available"
}


module "vpc" {
    source = "./modules/vpc"

    availability_zone = data.aws_availability_zones.available.names[0]
}

module "instances" {
    source = "./modules/aws_instance"

    #Todo In a real world use case we would possibly use a foreach to create multiple instances and each instance would connect to an external database. With the load balancer switching between each.

    availability_zone = data.aws_availability_zones.available.names[0]
    grafana_interface = module.vpc.grafana_interface
    grafana_subnet = module.vpc.grafana_subnet
    grafana-prod = module.vpc.grafana-prod
    allow-web = module.vpc.allow-web
}





