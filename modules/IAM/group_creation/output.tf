// output "username" {
//     value = {for p in aws_iam_user.user : p.name => p.arn}

// }

// output "secrets" {
//   value     = {for p in aws_iam_access_key.user : p.id => p.encrypted_secret}
// }

// // output "secret_access_key" {
// //   value     = {for p in aws_iam_access_key.user : p.encrypted_secret}
// // }

output "group_membership" {
    value = aws_iam_group.developers.name
}