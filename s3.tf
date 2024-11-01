# Create an S3 bucket
resource "aws_s3_bucket" "video_bucket" {
  bucket = "kemzzy-new-video-bucket"

  tags = {
    Name = "Video bucket"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "video_bucket_versioning" {
  bucket = aws_s3_bucket.video_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Bucket policy to allow read access from CloudFront and prevent direct access to our bucket
resource "aws_s3_bucket_policy" "video_stream" {
  bucket = aws_s3_bucket.video_bucket.id
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
         {
            "Sid": "AllowLegacyOAIReadOnly",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.cloudfront_OAI.id}"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.video_bucket.bucket}/*"
        }
      ]
  }
  POLICY
}

# replace with the path to the video you want to upload
resource "aws_s3_object" "new_video" {
  bucket       = aws_s3_bucket.video_bucket.id
  key          = "new-video"
  source       = "${path.module}/Bleach-356.mp4"
  etag         = filemd5("${path.module}/Bleach-356.mp4")
  content_type = "video/mp4"

  depends_on = [aws_s3_bucket.video_bucket]
}


