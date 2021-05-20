// provider "aws" {
//   region = "us-east-1"
// }

// resource "aws_iam_user" "user" {
//   count = length(var.user_name)
//   name = var.user_name[count.index]
//   path = var.user_path

//   tags = var.user-tags
// }

// resource "aws_iam_access_key" "user" {
//   count = length(var.user_name)
//   user = aws_iam_user.user[count.index].name
//   pgp_key = data.local_file.pgp_key.content
// }

resource "aws_iam_group" "developers" {
  name = var.group_name
  path = var.group_path
}

resource "aws_iam_group_membership" "dev-team" {
  name = var.iam_group_membership_name
  count = length(var.user_name)
  users = var.iam_group_membership_user_list
  group = aws_iam_group.developers.name
}

resource "aws_iam_policy" "my_developer_policy" {
  name  = var.group_policy_name
  policy = jsonencode(var.policy_details)
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.my_developer_policy.arn
}