variable "user-tags" {
    type = map(any)
    default = {
        user_id = "1234"
    }

}

variable "user_path" {
    type = string
    default = "/"

}

variable "user_name" {
    type = any
    default = ["niha4", "niha5", "niha6"]

}

variable "user_policy" {
    type = any
    default = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  }
}

variable "gpg_location" {
    type = string
    default = "./public-key-base64-encoded.gpg"

}
