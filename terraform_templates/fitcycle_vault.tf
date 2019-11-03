resource "aws_s3_bucket" "bucket" {
  bucket = "addo-s3-demo-bucket"
  acl    = "private"

  tags = {
    Name        = "My Demo Bucket"
    Environment = "Dev"
  }
}
