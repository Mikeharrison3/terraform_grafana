variable "grafana_interface" {
  type = string
}

variable "grafana_subnet" { 
    type = string
}

variable "grafana-prod" {
    type = string
}

variable "allow-web" {
    type = string
}

variable "availability_zone" {
    description = "The availability zone that you want to use. Should be one in the aws_region"
    type = string
   # default = "us-east-1a" 
    }  
    

    variable "instance_count" {
    description = "The number of Granfa instances that you want to start"
    type = number
    default = 1
}