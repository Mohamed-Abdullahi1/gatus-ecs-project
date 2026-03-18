output "cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.gatus_cluster.id
}

output "cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.gatus_cluster.name
}

output "service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.gatus.name
}

output "service_id" {
  description = "ECS service ID"
  value       = aws_ecs_service.gatus.id
}

output "task_definition_arn" {
  description = "ECS task definition ARN"
  value       = aws_ecs_task_definition.gatus.arn
}

output "task_execution_role_arn" {
  description = "IAM role ARN used by ECS task execution"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_tasks_security_group_id" {
  description = "Security group ID for ECS tasks"
  value       = aws_security_group.ecs_tasks.id
}

output "cloudwatch_log_group_name" {
  description = "CloudWatch log group name for ECS container logs"
  value       = aws_cloudwatch_log_group.ecs.name
}