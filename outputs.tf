// AWS Route53 zone ID
output "route53_zone_id" {
  value = "${aws_route53_zone.zone.id}"
}
