variable "subdomain" {
  type    = string
  default = "videostream.devobs.me"
}

variable "cloudfront_priceClass" {
  type = string
  default = "PriceClass_100"
}

variable "environment" {
  type = string
  default = "dev"
}
  