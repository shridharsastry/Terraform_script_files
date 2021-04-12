provider "aws" {
  region = var.region
}

module "vpc" {
  source = "C:\\Users\\shrid\\Desktop\\GIT\\test\\Terraform_script_files\\aws\\ThreeTierApplication\\modules\\vpc"
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  vpc_tags = var.vpc_tags
  nacl-egress-protocol = var.nacl-egress-protocol
  map_public_ip_on_launch = var.map_public_ip_on_launch
  nacl-action = (var.nacl-action == "allow" ? "allow" : "deny")
  nacl-ingress-protocol = var.nacl-ingress-protocol
  nacl_rules = var.nacl_rules
  igw_tags = var.igw_tags
  #private-subnet_ids = var.private-subnet_ids
  #public-subnet_ids = var.public-subnet_ids
  
}


module "asg" {
  source = "C:\\Users\\shrid\\Desktop\\GIT\\test\\Terraform_script_files\\aws\\ThreeTierApplication\\modules\\asg"
  instance_type = var.instance_type
  desired_capacity = var.desired_capacity
  max_size = var.max_size
  min_size = var.min_size
  vpc_public_zone_identifier = module.vpc.public_subnet_info.ids
  vpc_private_zone_identifier = module.vpc.private_subnet_info.ids

}

module "elb" {
  source = "C:\\Users\\shrid\\Desktop\\GIT\\test\\Terraform_script_files\\aws\\ThreeTierApplication\\modules\\elb"
  public_subnets = module.vpc.public_subnet_info.ids
  private_subnets = module.vpc.private_subnet_info.ids
  private-asg-id = module.asg.private_asg_id.id
  public-asg-id = module.asg.public_asg_id.id
}