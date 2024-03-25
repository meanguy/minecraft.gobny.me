data "aws_iam_policy_document" "assume_role" {
    statement {
        effect = "Allow"

        principals {
            type = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]
    }
}

data "aws_iam_policy_document" "instance_role" {
    statement {
        actions = [
            "s3:PutObject",
        ]

        resources = [
            "arn:aws:s3:::${var.name_prefix}-gobnyme-backups",
        ]
    }
}
