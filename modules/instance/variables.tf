variable "server_port" {
    description = "The port server will use for http requests"
    default = 8080

}

variable "instance_name" {
    description = "names of instances"
    type = list
    default = ["shridharsastry-webserver0","shridharsastry-webserver1","shridharsastry-webserver2"]
}