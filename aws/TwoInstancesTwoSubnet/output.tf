
output "vpc_info" {
  value = aws_vpc.prod-vpc.id
}
output "subnet_info" {
  value = data.aws_subnet_ids.example.ids
}

