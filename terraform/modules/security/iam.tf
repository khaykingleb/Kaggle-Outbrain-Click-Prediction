resource "aws_iam_role" "emr" {
  name = "emr-role"

  assume_role_policy = <<-EOF
  {
  "Version": "2008-10-17",
  "Statement": [
      {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
          "Service": "elasticmapreduce.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
      }
  ]
  }
  EOF
}

resource "aws_iam_role_policy" "emr" {
  name = "emr-policy"
  role = aws_iam_role.emr.id

  policy = <<-EOF
  {
      "Version": "2012-10-17",
      "Statement": [{
          "Effect": "Allow",
          "Resource": "*",
          "Action": [
              "ec2:AuthorizeSecurityGroupEgress",
              "ec2:AuthorizeSecurityGroupIngress",
              "ec2:CancelSpotInstanceRequests",
              "ec2:CreateNetworkInterface",
              "ec2:CreateSecurityGroup",
              "ec2:CreateTags",
              "ec2:DeleteNetworkInterface",
              "ec2:DeleteSecurityGroup",
              "ec2:DeleteTags",
              "ec2:DescribeAvailabilityZones",
              "ec2:DescribeAccountAttributes",
              "ec2:DescribeDhcpOptions",
              "ec2:DescribeInstanceStatus",
              "ec2:DescribeInstances",
              "ec2:DescribeKeyPairs",
              "ec2:DescribeNetworkAcls",
              "ec2:DescribeNetworkInterfaces",
              "ec2:DescribePrefixLists",
              "ec2:DescribeRouteTables",
              "ec2:DescribeSecurityGroups",
              "ec2:DescribeSpotInstanceRequests",
              "ec2:DescribeSpotPriceHistory",
              "ec2:DescribeSubnets",
              "ec2:DescribeVpcAttribute",
              "ec2:DescribeVpcEndpoints",
              "ec2:DescribeVpcEndpointServices",
              "ec2:DescribeVpcs",
              "ec2:DetachNetworkInterface",
              "ec2:ModifyImageAttribute",
              "ec2:ModifyInstanceAttribute",
              "ec2:RequestSpotInstances",
              "ec2:RevokeSecurityGroupEgress",
              "ec2:RunInstances",
              "ec2:TerminateInstances",
              "ec2:DeleteVolume",
              "ec2:DescribeVolumeStatus",
              "ec2:DescribeVolumes",
              "ec2:DetachVolume",
              "iam:GetRole",
              "iam:GetRolePolicy",
              "iam:ListInstanceProfiles",
              "iam:ListRolePolicies",
              "iam:PassRole",
              "s3:CreateBucket",
              "s3:Get*",
              "s3:List*",
              "sdb:BatchPutAttributes",
              "sdb:Select",
              "sqs:CreateQueue",
              "sqs:Delete*",
              "sqs:GetQueue*",
              "sqs:PurgeQueue",
              "sqs:ReceiveMessage",
              "application-autoscaling:RegisterScalableTarget",
              "application-autoscaling:DeregisterScalableTarget",
              "application-autoscaling:PutScalingPolicy",
              "application-autoscaling:DeleteScalingPolicy",
              "application-autoscaling:Describe*"
          ]
      }]
  }
  EOF
}


resource "aws_iam_role" "instance" {
  name = "ec2-instance-role"

  assume_role_policy = <<-EOF
  {
  "Version": "2008-10-17",
  "Statement": [
      {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
          "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
      }
  ]
  }
  EOF
}

resource "aws_iam_instance_profile" "this" {
  name = "ec2-instance-profile"
  role = aws_iam_role.instance.name
}

resource "aws_iam_role" "autoscaling" {
  name               = "autoscaling-role"
  assume_role_policy = <<-EOF
  {
  "Version": "2012-10-17",
  "Statement": [
      {
      "Effect": "Allow",
      "Principal": {
          "Service": [
          "application-autoscaling.amazonaws.com",
          "elasticmapreduce.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
      }
  ]
  }
  EOF
}

resource "aws_iam_role_policy" "autoscaling" {
  name = "autoscaling-policy"
  role = aws_iam_role.autoscaling.id

  policy = <<-EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": [
                  "elasticmapreduce:ListInstanceGroups",
                  "elasticmapreduce:ModifyInstanceGroups"
              ],
              "Effect": "Allow",
              "Resource": "*"
          }
      ]
  }
  EOF
}
