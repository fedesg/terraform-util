resource "aws_lb" "sisorg_alb_1" {
  name     = "sisorg-alb-1-${var.env_short}"
  internal = true

  subnets                    = [aws_subnet.sisorg_subnet_9_containers.id, aws_subnet.sisorg_subnet_10_containers.id]
  security_groups            = [aws_security_group.sisorg_sg_internal.id, aws_security_group.sisorg_sg_stp.id]
  load_balancer_type         = "application"
  enable_deletion_protection = false # configure deletion protection
  access_logs {
    bucket  = "sisorg-alb-logs-${var.env_short}"
    prefix  = "sisorg-alb-1"
    enabled = true
  }

  tags = {
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Entry"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

output "internal-uri" {
  value = "http://${aws_lb.sisorg_alb_1.dns_name}"
}

resource "aws_lb_listener" "sisorg_alb_1_lt" {
  load_balancer_arn = aws_lb.sisorg_alb_1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.template_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "static_1" {
  listener_arn = aws_lb_listener.sisorg_alb_1_lt.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.template_tg.arn
  }

  condition {
    host_header {
      values = [aws_route53_record.dns_template.name]
    }
  }
}
