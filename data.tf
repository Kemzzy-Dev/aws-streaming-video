
data "aws_route53_zone" "zone" {
  name = "devobs.me"
}

data "aws_acm_certificate" "cert" {
  domain   = "devobs.me"
  statuses = ["ISSUED"]
}