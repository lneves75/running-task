/*

locals {
  // fake elb name
  // If this elb was created by an ingress controller in k8s than we can obtain this value by using the 
  // service data source that comes with the k8s terraform provider
  ingress_elb_domain = "zIxrnzFRf5k15A5z0WdGZZifsbcGMLwkkvLs-1575862453.eu-west-1.elb.amazonaws.com"
  ingress_elb_name = "${element(split("-",local.ingress_elb_domain),0)}"
}

// assuming a domain certificate managed in AWS ACM
data "aws_acm_certificate" "cdn" {
  provider = "aws.us-east-1"
  domain   = "${module.stage.domain}"
  statuses = ["ISSUED"]
}

// this assumes that we would have a service to manage image requests as origin
// that service would be exposed via the k8s ingress elb
resource "aws_cloudfront_distribution" "image_proxy" {
  enabled      = true
  price_class  = "PriceClass_200"
  http_version = "http2"

  origin {
    domain_name = local.ingress_elb_domain
    origin_id   = "ELB-${local.ingress_elb_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2", "SSLv3"]
    }
  }

  default_cache_behavior {
    target_origin_id = "ELB-${local.ingress_elb_name}"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }

      headers = ["Host", "Origin", "Accept"]
    }

    min_ttl     = 3600
    default_ttl = 2592000
    max_ttl     = 7776000

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.cdn.arn
    ssl_support_method       = "sni-only" // using vip would cause cloudfront to use dedicated IP and that means extra costs
    minimum_protocol_version = "TLSv1"
  }

  aliases = [local.ingress_elb_domain]
}

*/