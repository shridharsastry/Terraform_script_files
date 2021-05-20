provider "aws" {
  region = "us-east-1"
}


module "create_user" {
    source = "./modules/user_creation/"
    user-tags = var.user-tags
    user_path = var.user_path
    user_name = var.user_name
    gpg_location = var.gpg_location

}

module "create_group_for_users" {
    source = "./modules/group_creation/"
    group_name = var.group_name
    group_path = var.group_path
    iam_group_membership_name = var.group_name
    iam_group_membership_user_list = module.create_user.user_names
    group_policy_name = var.group_policy_name
    policy_details = var.policy_details
    user_name = var.user_name
}
