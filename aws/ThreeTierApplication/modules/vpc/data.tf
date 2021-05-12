/*
data "aws_vpcs" "selected" {
  tags = {
    name = "main-vpc"
  }
}

*/
data "aws_availability_zones" "available" {}


data "aws_subnet_ids" "subnet_ids" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id
}


data "aws_subnet_ids" "public-subnet_ids" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id
  filter {
    name   = "tag:Tier"
    values = ["Public"]
  }
}

data "aws_subnet_ids" "private-subnet_ids" {
  depends_on = [aws_vpc.main]
  vpc_id     = aws_vpc.main.id
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}
