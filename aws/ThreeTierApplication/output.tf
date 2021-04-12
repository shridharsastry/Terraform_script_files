/*
output "vpc_info" {
  value = module.vpc.vpc_info
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}


output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
*/

output "public_asg_id" {
    value = module.asg.public_asg_id
}

output "private_asg_id" {
    value = module.asg.private_asg_id
}
