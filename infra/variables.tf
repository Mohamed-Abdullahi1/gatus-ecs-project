variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "gatus"
}

variable "domain_name" {
  description = "Fully qualified domain for the app"
  type        = string
  default     = "gatus.moabdullahi.uk"
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID for the delegated subdomain"
  type        = string
}

variable "container_image" {
  description = "ECR image URI"
  type        = string
}