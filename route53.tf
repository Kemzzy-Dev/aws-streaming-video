# resource "aws_route53_zone" "primary" {
#   name = "kemzzy-video.com"
# }

# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "www.kemzzy-video.com"
#   type    = "A"
#   ttl     = 300

#   alias {
#     name                   = aws_cloudfront_distribution.s3_distribution.domain_name
#     zone_id                = aws_cloudfront_distribution.s3_distribution.
#     evaluate_target_health = false
#   }
# }