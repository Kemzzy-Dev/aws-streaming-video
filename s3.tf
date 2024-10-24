# Create an S3 bucket
resource "aws_s3_bucket" "video_bucket" {
  bucket = "my-video-bucket"

  tags = {
    Name = "Video bucket"
  }
}

resource "aws_s3_bucket_acl" "video_bucket_acl" {
  bucket = aws_s3_bucket.video_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "video_bucket_versioning" {
  bucket = aws_s3_bucket.video_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "new_video" {
  bucket = aws_s3_bucket.video_bucket.id
  key    = "new video"
  source = "${path.module}/Bleach-82.mkv"
  etag   = filemd5("${path.module}/Bleach-82.mkv")
}