output "certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.gatus.certificate_arn
}

output "domain_name" {
  description = "Domain name associated with the ACM certificate"
  value       = aws_acm_certificate.gatus.domain_name
}