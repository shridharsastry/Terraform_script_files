resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  tags = var.vpc_tags
}

resource "aws_network_acl" "main-nacl" {
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = [for rule_obj in var.nacl_rules : {
      port       = rule_obj.port
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = var.nacl-ingress-protocol
      rule_no    = ingress.value["rule_no"]
      action     = var.nacl-action
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["port"]
      to_port    = ingress.value["port"]
    }
  }

  dynamic "egress" {
    for_each = [for rule_obj in var.nacl_rules : {
      port       = rule_obj.port
      rule_no    = rule_obj.rule_num
      cidr_block = rule_obj.cidr
    }]
    content {
      protocol   = var.nacl-egress-protocol
      rule_no    = egress.value["rule_no"]
      action     = var.nacl-action
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["port"]
      to_port    = egress.value["port"]
    }
  }
  tags = {
    Name = "main-nacl"
  }
  subnet_ids = data.aws_subnet_ids.subnet_ids.ids
}

resource "aws_subnet" "private_subnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  cidr_block = "10.1.${10+count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = (var.map_public_ip_on_launch == false ? false : true)
  tags = {
    Name = format("%s-%s","PrivateSubnet",count.index)
    Tier = "Private"
  }

}

resource "aws_subnet" "public_subnet" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  cidr_block = "10.1.${20+count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = (var.map_public_ip_on_launch == false ? true : false)
  tags = {
    Name = format("%s-%s","PublicSubnet",count.index)
    Tier = "Public"
  }

}

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main.id
  tags = var.igw_tags
}

resource "aws_eip" "ngw-eip" {
  vpc = true
  depends_on = [aws_internet_gateway.main-igw]
}

resource "aws_nat_gateway" "main-ngw" {
  allocation_id = aws_eip.ngw-eip.id
  subnet_id     = tolist (data.aws_subnet_ids.subnet_ids.ids)[0]
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = {
    Name = "public-rt"
  }

}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main-ngw.id
  }

  tags = {
    Name = "private-rt"
  }

}


resource "aws_route_table_association" "public" {
  depends_on = [aws_subnet.public_subnet]
  count = length(tolist(data.aws_subnet_ids.public-subnet_ids.ids))
  subnet_id = tolist(data.aws_subnet_ids.public-subnet_ids.ids)[count.index]
  #element(aws_subnet.public_subnet.*.id, count_index)
  route_table_id = aws_route_table.public-rt.id

}


resource "aws_route_table_association" "private" {
  depends_on = [aws_subnet.private_subnet]
  count = length(tolist(data.aws_subnet_ids.private-subnet_ids.ids))
  subnet_id = tolist(data.aws_subnet_ids.private-subnet_ids.ids)[count.index]
  #element(aws_subnet.public_subnet.*.id, count_index)
  route_table_id = aws_route_table.private-rt.id

}
