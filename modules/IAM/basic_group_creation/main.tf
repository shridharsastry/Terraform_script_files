provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "user" {
  count = length(var.user_name)
  name = var.user_name[count.index]
  path = var.user_path

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "user" {
  count = length(var.user_name)
  user = aws_iam_user.user[count.index].name
  pgp_key = data.local_file.pgp_key.content
}

resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}

resource "aws_iam_group_membership" "dev-team" {
  name = "tf-testing-group-membership"
  count = length(var.user_name)
  users = [
    
    aws_iam_user.user[count.index].name,
  ]

  group = aws_iam_group.developers.name
}

resource "aws_iam_policy" "my_developer_policy" {
  name  = "my_developer_policy"
  #group = aws_iam_group.developers.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.my_developer_policy.arn
}