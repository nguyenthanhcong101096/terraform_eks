resource "aws_iam_role" "cert_manager_role" {
  name = "cert-manager-${var.app}-${var.env}"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project   = "Terraform K8s Example Cluster"
    Terraform = "True"
  }
}

resource "aws_iam_role_policy" "cert_manager_policy" {
  name = "cert-manager-policy"
  role = aws_iam_role.cert_manager_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "route53:GetChange",
        "Resource" : "arn:aws:route53:::change/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : "arn:aws:route53:::hostedzone/Z0528197119BZEH06JUX3"
      },
    ]
  })
}
