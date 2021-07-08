variable "vpc_cidr_block" {
    description = "Default CIDR block for the VPC"
    type = string
    default = "172.20.0.0/16"
}

variable "availability_zone" {
    description = "The availability zone that you want to use. Should be one in the aws_region"
    type = string
   # default = "us-east-1a" 
    }  

    variable "vpc_subnet" {
    description = "Subnet for inside of VPC"
    type = string
    default = "172.20.100.0/24" 
}