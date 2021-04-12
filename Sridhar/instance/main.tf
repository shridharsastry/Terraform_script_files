provider "aws" {
  region = "us-east-1"
}

module "sridhar-instance" {
  source = "C:\\Users\\shrid\\Documents\\Terraform_script_files\\modules\\instance"
}


output "public_ip" {
  value = module.sridhar-instance[*].public_ip
  }

