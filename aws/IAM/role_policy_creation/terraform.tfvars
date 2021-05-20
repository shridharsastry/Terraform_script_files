role_name = "ec2_s3_full_access_role_v2"



role_policy_name = "ec2_s3_full_access_role_policy_v2"

policy_to_be_assigned = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  }

  who_assumes_role = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  }