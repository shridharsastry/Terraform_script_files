output "secret_key_id" {
  value     = aws_iam_access_key.niha3.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.niha3.encrypted_secret
  sensitive = true
}