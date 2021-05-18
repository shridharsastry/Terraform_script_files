
resource "aws_launch_template" "asg-launch-template" {
  name_prefix   = "asg-launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "public-asg" {
  vpc_zone_identifier = var.vpc_public_zone_identifier
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  tag {
    key                 = "key"
    value               = "public-asg"
    propagate_at_launch = true
  }

  launch_template {
    id      = aws_launch_template.asg-launch-template.id
    version = "$Latest"
  }

}

resource "aws_autoscaling_group" "private-asg" {
  vpc_zone_identifier = var.vpc_private_zone_identifier
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  tag {
    key                 = "key"
    value               = "private-asg"
    propagate_at_launch = true
  }

  launch_template {
    id      = aws_launch_template.asg-launch-template.id
    version = "$Latest"
  }

}
