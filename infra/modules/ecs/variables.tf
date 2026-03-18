variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "gatus"
}

variable "vpc_id" {
  description = "VPC ID for ECS resources"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN for the ECS service"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "container_image" {
  description = "Container image URI from ECR"
  type        = string
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 8080
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}

variable "task_cpu" {
  description = "Fargate CPU units"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Fargate memory in MiB"
  type        = string
  default     = "512"
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention period"
  type        = number
  default     = 7
}