output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = data.aws_subnet_ids.subnet_ids.ids
}


output "public_subnet_info" {
  value = data.aws_subnet_ids.public-subnet_ids
}

output "private_subnet_info" {
  value = data.aws_subnet_ids.private-subnet_ids
}
