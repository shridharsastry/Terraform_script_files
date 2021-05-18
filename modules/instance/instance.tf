terraform {
  required_version = ">= 0.12"

}

resource "aws_instance" "example" {
  count = length(var.instance_name)
  # name = element(var.instance_name, count.index)
  ami                    = "ami-40d28157"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "I love you Pandu!" > index.html
              nohup busybox httpd -f -p var.server_port &
              EOF

  tags = {
    Name = var.instance_name[count.index]
  }


}
