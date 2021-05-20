output "group_membership" {
    value = module.create_group_for_users.group_membership
}

output "user_names" {
  value = module.create_user.user_names
}