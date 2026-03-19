output "alb_security_group_id" {
  description = "Security group ID of the ALB"
  value       = aws_security_group.alb.id
}

output "target_group_arn" {
  description = "ARN of the ALB target group"
  value       = aws_lb_target_group.gatus.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.gatus_alb.dns_name
}

output "alb_zone_id" {
  description = "Hosted zone ID of the ALB"
  value       = aws_lb.gatus_alb.zone_id
}