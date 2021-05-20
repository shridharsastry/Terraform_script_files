resource "aws_iam_user" "user" {
  count = length(var.user_name)
  name = var.user_name[count.index]
  path = var.user_path

  tags = var.user-tags
}

resource "aws_iam_access_key" "user" {
  count = length(var.user_name)
  user = aws_iam_user.user[count.index].name
  pgp_key = data.local_file.pgp_key.content
}

resource "aws_iam_user_policy" "user_ro" {
  count = length(var.user_name)
  name = var.user_name[count.index]
  user = aws_iam_user.user[count.index].name
  policy = var.user_policy

}