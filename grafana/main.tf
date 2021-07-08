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

#    cidr_block = var.vpc_cidr_block
 availability_zone = data.aws_availability_zones.available.names[0]
}

module "instances" {
    source = "./modules/aws_instance"
    availability_zone = data.aws_availability_zones.available.names[0]
    grafana_interface = module.vpc.grafana_interface
    grafana_subnet = module.vpc.grafana_subnet
    grafana-prod = module.vpc.grafana-prod
    allow-web = module.vpc.allow-web
}





