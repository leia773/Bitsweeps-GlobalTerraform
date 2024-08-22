
variable "region"{
  type = string
}
variable "profile"{
 type = string 
}
variable "service_name" {
  type        = string
  description = "The name of the AWS App Runner service."
}

variable "app_runner_tags" {
  type        = map(string)
  description = "Tags to apply to the AWS App Runner service."
}

variable "ecr_arn" {
  type        = list(string)
  description = "The ARN of the Amazon ECR repository."
}

variable "app_port" {
  type        = number
  description = "The port on which the application runs."
}

variable "image_repository_type" {
  type        = string
  description = "The type of image repository used (e.g., 'ECR')."
}

variable "image_identifier" {
  type        = string
  description = "The identifier of the Docker image."
}

variable "auto_deployments_enabled" {
  default     = false
  type = bool
  description = "Whether automatic deployments are enabled."
}

variable "runtime_environment_variables" {
  description = "Environment variables for the App Runner service."
  type        = map(string)
  default     = {}
}

variable "cpu" {
  type     = number
  description = "The amount of CPU allocated to each instance."
}

variable "memory" {
  type =       number
  description = "The amount of memory allocated to each instance."
}

variable "is_publicly_accessible" {
  type        = bool
  default     = true
  description = "Whether the service is publicly accessible."
}

variable "egress_type" {
  type        = string
  default     = "DEFAULT"
  description = "The type of egress traffic (e.g., 'DEFAULT')."
}

variable "auto_scaling_configuration_name" {
  type        = string
  description = "The name of the App Runner auto scaling configuration."
}

variable "max_concurrency" {
  type        = number
  description = "The maximum concurrency setting."
}

variable "min_size" {
  type        = number
  description = "The minimum number of instances."
}

variable "max_size" {
  type        = number
  description = "The maximum number of instances."
}

variable "auto_scale_tags" {
  type        = map(string)
  description = "Tags to apply to the auto scaling configuration."
}

variable "env" {
  type        = string
  description = "The environment (e.g., 'development', 'production')."
}

variable "domain_name" {
  type        = string
  description = "The domain name associated with the App Runner service."
}

variable "codebuild_project_arn"{

  type        = string
 description = "Tcodebuild_project_arn to the App Runner service."
}
