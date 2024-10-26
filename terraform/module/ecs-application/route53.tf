resource "aws_route53_record" "this" {
  count   = var.enable_cloudfront == false ? 1 : 0
  zone_id = var.route53_id
  name    = var.app_hostname
  type    = "CNAME"
  ttl     = "1"
  records = [var.application.lb_dns]
} 