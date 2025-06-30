# First
resource "aws_iam_user" "iamlim1" {
  name = "iamlim1"
}

resource "aws_iam_user_group_membership" "iamlim1_membership" {
  user   = aws_iam_user.iamlim1.name
  groups = [aws_iam_group.iamlim.name]
}

resource "aws_iam_user_policy_attachment" "s3_to_iamlim1" {
  user       = aws_iam_user.iamlim1.name
  policy_arn = aws_iam_policy.s3_file_read_only.arn
}

# Second
resource "aws_iam_user" "iamlim2" {
  name = "iamlim2"
}

resource "aws_iam_user_group_membership" "iamlim2_membership" {
  user   = aws_iam_user.iamlim2.name
  groups = [aws_iam_group.iamlim.name]
}
