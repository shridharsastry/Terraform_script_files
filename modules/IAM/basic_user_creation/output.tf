output "username" {
    value = {for p in aws_iam_user.user : p.name => p.arn}

}

output "secrets" {
  value     = {for p in aws_iam_access_key.user : p.id => p.encrypted_secret}
}