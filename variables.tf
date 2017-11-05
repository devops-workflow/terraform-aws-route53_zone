
// Standard Variables

variable "name" {
  description = "Name"
}
variable "environment" {
  description = "Environment (ex: dev, qa, stage, prod)"
}
variable "namespaced" {
  description = "Namespace all resources (prefixed with the environment)?"
  default     = true
}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

// Module specific Variables

variable "alias_records" {
  description = "Map of DNS alias records"
}
variable "alias_zone" {
  description = "The zone ID where origin zone is hosted"
}
variable "records" {
  description = "Map of DNS records"
}
variable "vpc_id" {
  description = "AWS VPC ID"
}
