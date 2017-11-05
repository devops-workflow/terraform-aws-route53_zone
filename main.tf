/**
 * AWS Route53 Zone Terraform Module
 * =====================
 *
 * Usage:
 * ------
 *
 *     module "route53_zone" {
 *       source         = "../tf_route53_zone"
 *       name           = "corp.com"
 *       environment    = "dev"
 *       records        = ""
 *       alias_records  = ""
 *       alias_zone     = ""
 *     }
**/

resource "aws_route53_zone" "zone" {
  name = "${var.name}"
  #comment = "zone-${var.name}"
  vpc_id = "${var.vpc_id}"
  tags = "${ merge(
    var.tags,
    map("Name", var.namespaced ?
     format("%s-%s-dns_zone", var.environment, var.name) :
     format("%s-dns_zone", var.name) ),
    map("Environment", var.environment),
    map("Terraform", "true") )}"
}

resource "aws_route53_record" "record" {
  count = "${length(var.records)}"
  zone_id = "${aws_route53_zone.zone.id}"
  name = "${element(keys(var.records), count.index)}"
  type = "A"
  ttl = "300"
  records = ["${var.records[element(keys(var.records), count.index)]}"]
}

resource "aws_route53_record" "record_alias" {
  count = "${length(var.alias_records)}"
  zone_id = "${aws_route53_zone.zone.id}"
  name = "${element(keys(var.alias_records), count.index)}"
  type = "A"
  alias {
    name = "${var.alias_records[element(keys(var.alias_records), count.index)]}"
    zone_id = "${var.alias_zone}"
    evaluate_target_health = false
  }
}

# TODO: health check, cloudwatch
