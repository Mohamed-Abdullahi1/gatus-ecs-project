variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "gatus"
}

variable "image_tag_mutability" {
  description = "Whether image tags can be overwritten"
  type        = string
  default     = "MUTABLE"
}