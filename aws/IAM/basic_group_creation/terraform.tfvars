user-tags = {
        user_id = "1234"
    }

user_path = "/"

user_name = ["niha4", "niha5", "niha6"]

gpg_location = "./public-key-base64-encoded.gpg"

group_name = "developers"

group_path = "/"

iam_group_membership_name = "tf-testing-group-membership"

iam_group_membership_user_list = ["niha4", "niha5", "niha6"]

group_policy_name = "my_developer_policy"

policy_details = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  }

