provider "aws" {
  region = "us-east-1"
}

module "user_create" {
  source = "./modules/user_creation/"
  user-tags = var.user-tags
  user_path = var.user_path
  user_name = var.user_name
  user_policy = jsonencode(var.user_policy)
  gpg_location = var.gpg_location
}

