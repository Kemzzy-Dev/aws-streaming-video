resource "aws_cloudfront_origin_access_identity" "cloudfront_OAI" {
  comment = "OAI for video streaming S3 bucket"
}

# resource "aws_cloudfront_origin_access_control" "sample_cloudfront_OAC" {
#   name                              = "cloudfront OAC"
#   description                       = "cloudfront Policy"
#   origin_access_control_origin_type = "s3"
#   signing_behavior                  = "always"
#   signing_protocol                  = "sigv4"
# }

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.video_bucket.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.video_bucket.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cloudfront_OAI.cloudfront_access_identity_path
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  comment         = "play video"

  #   aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.video_bucket.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = [ ]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  depends_on = [ aws_s3_bucket.video_bucket ]
}


output "cloudfront_url" { 
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}


