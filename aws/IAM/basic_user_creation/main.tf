provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "niha3" {
  name = "niha3"
  path = "/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "niha3" {
  user = aws_iam_user.niha3.name
  pgp_key = data.local_file.pgp_key.content
}

resource "aws_iam_user_policy" "niha3_ro" {
  name = "test"
  user = aws_iam_user.niha3.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

