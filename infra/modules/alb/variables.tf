variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "gatus"
}

variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}

variable "container_port" {
  description = "Container port used by the target group"
  type        = number
  default     = 8080
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}