/*
data "aws_vpcs" "selected" {
  tags = {
    name = "main-vpc"
  }
}
*/

data "aws_availability_zones" "available" {}


data "aws_subnet_ids" "subnet_ids" {
  vpc_id = module.vpc.vpc_id
}


data "aws_subnet_ids" "public-subnet_ids" {
  vpc_id = module.vpc.vpc_id
  filter {
    name   = "tag:Tier"
    values = ["Public"]
  }
}

data "aws_subnet_ids" "private-subnet_ids" {
  vpc_id = module.vpc.vpc_id
  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}