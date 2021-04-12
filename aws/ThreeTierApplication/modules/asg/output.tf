output "public_asg_id" {
    value = data.aws_autoscaling_groups.public-asg
}

output "private_asg_id" {
    value = data.aws_autoscaling_groups.private-asg
}
