provider "aws" {
  region = "us-east-1"
}


#  1. Create vpc

resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "prod-vpc"
  }
}


#  2. Create Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id


}


#  3. Create Custom Route Table

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "prod-route-table"
  }
}

#  4. Create a Subnet 

resource "aws_subnet" "prod-subnet1" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "prod-subnet1"
  }
}

resource "aws_subnet" "prod-subnet2" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "prod-subnet2"
  }
}

#  5. Associate subnet with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.prod-subnet1.id
  route_table_id = aws_route_table.prod-route-table.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.prod-subnet2.id
  route_table_id = aws_route_table.prod-route-table.id
}

#  6. Create Security Group to allow port 22,80,443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}


#  9. Create Ubuntu server and install/enable apache2

resource "aws_instance" "web-server-instance" {
  depends_on = [
    aws_subnet.prod-subnet1,
    aws_subnet.prod-subnet2,
  ]
  count         = var.instances_per_subnet * length(data.aws_subnet_ids.example.ids)
  ami           = "ami-085925f297f89fce1"
  instance_type = "t2.micro"
  #availability_zone = "us-east-1a"
  key_name  = "shridharsastry-icloud-us-east-1"
  subnet_id = sort(data.aws_subnet_ids.example.ids)[count.index % length(data.aws_subnet_ids.example.ids)]


  vpc_security_group_ids = [
    aws_security_group.allow_web.id
  ]

  user_data = <<-EOF
                 #!/bin/bash
                 sudo apt update -y
                 sudo apt install apache2 -y
                 sudo systemctl start apache2
                 echo 'hi pandu!' > /var/www/html/index.html
                 EOF

  tags = {
    Name = format("%s-%s", var.vm_names, count.index + 1)
  }

}



