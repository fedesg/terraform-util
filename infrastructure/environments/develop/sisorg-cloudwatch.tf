# module "notify_slack" {
#   source = "terraform-aws-modules/notify-slack/aws"

#   sns_topic_name = "slack-topic"

#   slack_webhook_url = "https://hooks.slack.com/services/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"
#   slack_channel     = "sg-back-alert"
#   slack_username    = "sisorg-bot"
# }
# locals {
#   alarm_settings = {
#     "template" = {
#       target_group = aws_lb_target_group.template_tg.arn_suffix, load_balancer = aws_lb.sisorg_alb_1.arn_suffix
#     }
#   }
# }


# resource "aws_cloudwatch_metric_alarm" "nlb_healthyhosts" {
#   for_each            = local.alarm_settings
#   alarm_name          = "alarm-${each.key}-${var.env_short}"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = 1
#   metric_name         = "HealthyHostCount"
#   namespace           = "AWS/ApplicationELB"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = 1
#   alarm_description   = "Number of healthy nodes in Target Group"
#   actions_enabled     = "true"
#   datapoints_to_alarm = 1
#   alarm_actions       = [module.notify_slack.this_slack_topic_arn]
#   ok_actions          = [module.notify_slack.this_slack_topic_arn]
#   treat_missing_data  = "breaching"
#   dimensions = {
#     TargetGroup  = each.value.target_group
#     LoadBalancer = each.value.load_balancer
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "nlb_4xx_errors" {
#   for_each            = local.alarm_settings
#   alarm_name          = "4XX-alarm-${each.key}-${var.env_short}"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = 1
#   metric_name         = "HTTPCode_Target_4XX_Count"
#   namespace           = "AWS/ApplicationELB"
#   period              = "43200"
#   statistic           = "Sum"
#   threshold           = 10
#   alarm_description   = "Number of 4xx errors in Target Group"
#   actions_enabled     = "true"
#   alarm_actions       = [module.notify_slack.this_slack_topic_arn]
#   treat_missing_data  = "notBreaching"
#   dimensions = {
#     TargetGroup  = each.value.target_group
#     LoadBalancer = each.value.load_balancer
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "nlb_alb_5xx_errors" {
#   for_each            = local.alarm_settings
#   alarm_name          = "5XX-alb-alarm-${each.key}-${var.env_short}"
#   alarm_description   = "Load balancer is not able to forward an incoming request to one of the EC2 instances"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = 5
#   metric_name         = "HTTPCode_ELB_5XX_Count"
#   namespace           = "AWS/ApplicationELB"
#   period              = "60"
#   statistic           = "Sum"
#   threshold           = 2
#   actions_enabled     = "true"
#   alarm_actions       = [module.notify_slack.this_slack_topic_arn]
#   treat_missing_data  = "notBreaching"
#   dimensions = {
#     LoadBalancer = each.value.load_balancer
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "nlb_target_5xx_errors" {
#   for_each            = local.alarm_settings
#   alarm_name          = "5XX-alarm-${each.key}-${var.env_short}"
#   alarm_description   = "Target 5XX error"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = 5
#   metric_name         = "HTTPCode_Target_5XX_Count"
#   namespace           = "AWS/ApplicationELB"
#   period              = "60"
#   statistic           = "Sum"
#   threshold           = 2
#   actions_enabled     = "true"
#   alarm_actions       = [module.notify_slack.this_slack_topic_arn]
#   treat_missing_data  = "notBreaching"
#   dimensions = {
#     TargetGroup  = each.value.target_group
#     LoadBalancer = each.value.load_balancer
#   }
# }
