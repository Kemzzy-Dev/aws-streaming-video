
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "videostream.devobs.me"
  type    = "CNAME"
  ttl     = 300
  records = [aws_cloudfront_distribution.s3_distribution.domain_name]

  lifecycle {
    create_before_destroy = true
  }

}


# Create route53 zone
# resource "aws_route53_zone" "primary" {
#   name = "devobs.me"
# }

# # Create an ACM certificate
# resource "aws_acm_certificate" "video_cert" {
#   domain_name               = "devobs.me"
#   subject_alternative_names = ["*.devobs.me"]
#   validation_method         = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # Cert validation
# resource "aws_acm_certificate_validation" "validate_cert" {
#   certificate_arn         = aws_acm_certificate.video_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]

#   depends_on = [ aws_route53_record.certificate_validation ]
# }


# resource "aws_route53_record" "certificate_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.video_cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.primary.zone_id

#   depends_on = [ aws_acm_certificate.video_cert ]
# }

# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 4.0"

#   domain_name  = "devobs.me"
#   zone_id      = aws_route53_zone.primary.zone_id

#   validation_method = "DNS"

#   subject_alternative_names = [
#     "videostream.devobs.me",
#   ]

#   wait_for_validation = true

#   tags = {
#     Name = "devobs.me"
#   }
# }

# output "acm" {
#   value = module.acm
# }
