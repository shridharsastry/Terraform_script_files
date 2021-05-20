# assume_role_policy defines who can assume this role. For example, if EC2 instance needs to assume the role for s3 full access then 
# assume_role_policy will have definition of ec2 instance not the actual s3 policy

# while creating policy using aws_iam_role_policy a role id is needed to attach the policy to
# while creating policy using aws_iam_policy a role id is not needed in which case aws_iam_role_policy_attachment is needed to attach a aws_iam_policy policy to a role

#jsonencode function will convert HCL language to json


resource "aws_iam_role" "ec2_s3_full_access_role" {
  name = var.role_name
  assume_role_policy = var.who_assumes_role

}
