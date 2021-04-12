
data "aws_subnet_ids" "example" {
  vpc_id = aws_vpc.prod-vpc.id
  depends_on = [
    aws_subnet.prod-subnet1,
    aws_subnet.prod-subnet2
  ]
}

/*
data "aws_subnet" "example" {
  #for_each = data.aws_subnet_ids.example.ids
  #id       = each.value
  count = data.aws_subnet_ids.example.ids
  id    = tolist(data.aws_subnet_ids.example.ids)[count.index]
}

*/