resource "aws_lb" "public-elb-asg" {
  name               = "public-elb-asg"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = "public-elb"
  }
}

resource "aws_lb" "private-elb-asg" {
  name               = "private-elb-asg"
  internal           = true
  load_balancer_type = "network"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets = var.private_subnets

  enable_deletion_protection = false

  tags = {
    Name = "private-elb"
  }
}

/*
resource "aws_autoscaling_attachment" "private-elb-asg-attachment" {
  autoscaling_group_name = var.private-asg-id
  elb                    = aws_lb.private-elb-asg.id
}

resource "aws_autoscaling_attachment" "public-elb-asg-attachment" {
  autoscaling_group_name = var.public-asg-id
  elb                    = aws_lb.public-elb-asg.id
}
*/