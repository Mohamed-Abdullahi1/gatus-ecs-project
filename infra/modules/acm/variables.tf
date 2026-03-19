variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "gatus"
}

variable "domain_name" {
  description = "Fully qualified domain name for the certificate"
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID used for DNS validation"
  type        = string
}