variable "user_name" {
    type = any
}

variable "group_name" {
    type = string
}

variable "group_path" {
    type = string
}

variable "iam_group_membership_name" {
    type = string
}

variable "iam_group_membership_user_list" {
    type = list
}

variable "group_policy_name" {
    type = string
}

variable "policy_details" {
    type = any
}