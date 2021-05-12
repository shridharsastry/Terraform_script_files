terraform {
  backend "s3" {
    bucket = "shridharsastry-icloud-terraform-backend"
    key    = "terraform-state/s3-backend"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "centos" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "name"
    values = ["Ubuntu*"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.centos.id
  instance_type = "t2.micro"
  user_data     = <<-EOF
              #!/bin/bash
              echo "I love you Pandu!" > index.html
              nohup busybox httpd -f -p var.server_port &
              EOF

  tags = {
    Name = "terraform-example"
  }


}