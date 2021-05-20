variable "user-tags" {
    type = map(any)  
}

variable "user_path" {
    type = string
}

variable "user_name" {
    type = any
}

variable "gpg_location" {
    type = string
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