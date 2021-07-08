variable "aws_region" {
    description = "Your prefered region"
    type = string
    default = "us-east-1"
}

variable "vpc_cidr_block" {
    description = "Default CIDR block for the VPC"
    type = string
    default = "172.20.0.0/16"
}
