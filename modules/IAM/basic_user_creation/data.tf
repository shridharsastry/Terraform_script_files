data "local_file" "pgp_key" {
  filename = "./public-key-base64-encoded.gpg"
}

data "aws_iam_policy_document" "user-policy" {
    statement {
        actions = [ "ec2:Describe*"]
        effect = "Allow"
        resources = [ "*" ]
    }

}