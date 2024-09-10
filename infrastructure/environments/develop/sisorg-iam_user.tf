################################## IAM - NOTIFICATIONS #################################
resource "aws_iam_user" "sg-main-user" {
  name = "sg-notification-ms-user"
  path = "/"

  tags = {
    "sisorg:service"        = "App"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "notification"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_iam_access_key" "sg-notification-ms-user" {
  user = aws_iam_user.sg-main-user.name
}
########################################################################################
