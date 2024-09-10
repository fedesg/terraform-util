resource "aws_route53_zone" "sisorg_primary" {
  name = "${var.env_short}.sisorg.xyx"
  // private_zone = true
  vpc {
    vpc_id = aws_vpc.sisorg_vpc.id
  }
  tags = {
    Name                    = "${var.env_short}-sisorg-route-53"
    "sisorg:service"        = "DevOps"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "Entry"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

########################### ALB 1 #################################
resource "aws_route53_record" "dns_template" {
  zone_id = aws_route53_zone.sisorg_primary.zone_id
  name    = "template.${aws_route53_zone.sisorg_primary.name}"
  type    = "CNAME"
  ttl     = "60"
  records = [aws_lb.sisorg_alb_1.dns_name]
}
