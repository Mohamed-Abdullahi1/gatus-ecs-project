output "record_fqdn" {
  description = "Fully qualified domain name of the Route53 record"
  value       = aws_route53_record.gatus.fqdn
}