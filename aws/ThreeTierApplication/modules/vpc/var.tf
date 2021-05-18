variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
}

variable "vpc_tags" {
  type = map(any)
}

variable "map_public_ip_on_launch" {
  type = bool
}

variable "nacl-egress-protocol" {
  type = string
}

variable "nacl-ingress-protocol" {
  type = string
}

variable "nacl-action" {
  type = string
}

variable "nacl_rules" {
  type = list(any)
}

variable "igw_tags" {
  type = map(any)
}

/*
variable "private-subnet_ids" {
    type = any
    #default = data.aws_subnet_ids.private-subnet_ids.ids
}

variable "public-subnet_ids" {
    type = any
    #default = data.aws_subnet_ids.public-subnet_ids.ids
}
*/