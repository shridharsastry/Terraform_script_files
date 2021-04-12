variable "region" {
    type = string
    default = "us-east-1"
}

variable "cidr_block" {
    type = string
    default = "10.1.0.0/16"
}

variable "instance_tenancy" {
    type = string
    default = "default"
}

variable "vpc_tags" {
    type = map
    default = {
        Name = "main-vpc"
    }
    
}

variable "map_public_ip_on_launch" {
    type = bool
    default = false
}

variable "nacl-egress-protocol" {
    type = string
    default = "tcp"
}

variable "nacl-ingress-protocol" {
    type = string
    default = "tcp"
}

variable "nacl-action" {
    type = string
    default = "allow"
}

variable "nacl_rules"{
    type = list
    default = [
        { port : 22,   rule_num : 100, cidr : "0.0.0.0/0" },
        { port : 80,   rule_num : 110, cidr : "0.0.0.0/0" },
        { port : 443,  rule_num : 120, cidr : "0.0.0.0/0" },
        
    ]
}

variable "igw_tags" {
    type = map
    default = {
        Name = "main-igw"
    }
    
}
/*
variable "private-subnet_ids" {
    type = any
    default = module.vpc.private_subnet_info
}

variable "public-subnet_ids" {
    type = any
    default = module.vpc.public_subnet_info
}
*/

# ASG related variables

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable  "desired_capacity" {
    type = number
    default = 6
}

variable  "max_size" {
    type = number
    default = 12
}

variable "min_size" {
    type = number
    default = 1
}

#ELB related variables

