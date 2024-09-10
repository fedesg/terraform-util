module "s3_bucket_for_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "sisorg-alb-logs-${var.env_short}"

  # Remove ACL
  # acl = "log-delivery-write"

  # Allow deletion of non-empty bucket
  force_destroy = true

  attach_elb_log_delivery_policy = true
  attach_lb_log_delivery_policy  = true
  lifecycle_rule = [
    {
      id      = "sisorg-alb-1"
      enabled = true
      filter = {
        prefix = "sisorg-alb-1/"
      }
      expiration = {
        days                         = 5
        expired_object_delete_marker = true
      }
    },
  ]
}


# resource "aws_s3_bucket" "terms_s3" {
#   bucket = "sisorg-terms-ms-${var.env_short}"

#   tags = {
#     "sisorg:service"        = "App"
#     "sisorg:environment"    = "${var.env_short}"
#     "sisorg:application"    = "terms"
#     "sisorg:taggingVersion" = "1.0.0"
#     "sisorg:organization"   = "${var.org_account}"
#     "sisorg:automated"      = "yes"
#   }
# }
