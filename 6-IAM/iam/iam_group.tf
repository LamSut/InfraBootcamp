resource "aws_iam_group" "iamlim" {
  name = "iamlim"
}

resource "aws_iam_group_policy_attachment" "amazon_to_iamlim" {
  group      = aws_iam_group.iamlim.name
  policy_arn = aws_iam_policy.ec2_instance_full_access.arn
}

resource "aws_iam_group_policy_attachment" "mysql_to_iamlim" {
  group      = aws_iam_group.iamlim.name
  policy_arn = aws_iam_policy.rds_instance_full_access.arn
}
