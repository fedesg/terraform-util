resource "aws_lb" "nlb" {
  name                       = "sisorg-nlb-${var.env_short}"
  internal                   = true
  load_balancer_type         = "network"
  subnets                    = [aws_subnet.sisorg_subnet_9_containers.id, aws_subnet.sisorg_subnet_10_containers.id]
  enable_deletion_protection = false
  tags = {
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Entry"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  name        = "nlb-tg-${var.env_short}"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.sisorg_vpc.id
  target_type = "alb"
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 6
    path                = "/health"
    protocol            = "HTTP"
    interval            = 30
    matcher             = "200-399"
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

resource "aws_lb_target_group_attachment" "nbl_tg_attachment" {
  target_group_arn = aws_lb_target_group.nlb_tg.arn
  target_id        = aws_lb.sisorg_alb_1.id
  port             = 80
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.id
  port              = "80"
  protocol          = "TCP"
  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg.arn
    type             = "forward"
  }
}
