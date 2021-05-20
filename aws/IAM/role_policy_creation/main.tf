# first two modules are for creation of role and policy
# iam_instance_profile named "test_profile" will allow the role to be attached to ec2 instance

provider "aws" {
    region = "us-east-1"

}

module "role_based_on_module" {
    source = "./modules/basic_role_creation/"
    role_name = "ec2_s3_full_access_role_v1"
    who_assumes_role = jsonencode(var.who_assumes_role)
    
}

module "policy_based_on_module" {
    source = "./modules/basic_role_policy_creation/"
    role_policy_name = var.role_policy_name
    role_id = module.role_based_on_module.role_info.id
    policy_to_be_assigned = var.policy_to_be_assigned

}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = module.role_based_on_module.role_info.name
}

resource "aws_instance" "role-test" {
  ami = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
}