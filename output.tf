output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "domain_url" {
  value = aws_route53_record.video_subdomain.name
}

output "bucket_name" {
  value = aws_s3_bucket.video_bucket.bucket
}