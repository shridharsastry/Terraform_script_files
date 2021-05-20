output "secrets" {
  value     = [{for p in aws_iam_access_key.user : p.id => p.encrypted_secret},
              {for p in aws_iam_user.user : p.name => p.arn}]
}

output "user_names" {
  value = var.user_name
}