
variable "instance_type" {
    type = string
}

variable  "desired_capacity" {
    type = number
}

variable  "max_size" {
    type = number
}

variable "min_size" {
    type = number
}

variable "vpc_public_zone_identifier" {
    type = any
}

variable "vpc_private_zone_identifier" {
    type = any
}
