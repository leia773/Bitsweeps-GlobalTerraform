variable "region" {
  description = "AWS region"
}

variable "role_name" {
  description = "Name for the IAM role"
  default     = "codebuild_role"
}

variable "policy_name" {
  description = "Name for the IAM policy"
  default     = "codebuild_permission_policy"
}


variable "projectName" {
  type        = string
  default     = "bitsweepscorebackend"
  description = "write the proper name sutiable for this project"


}

variable "build_timeout" {

  type        = number
  description = "specify the build time"
  default     = 12
  sensitive   = false

}

variable "codeBuildDes" {

  type        = string
  description = ""

}


variable "codeBuildSourceBuildspec" {

  type        = string
  description = "path of a yaml file"

}
variable "SourceUrl" {
  type        = string
  description = "provide the appropriate url "
}

variable "compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"

}
variable "image" {
  type    = string
  default = "aws/codebuild/amazonlinux2-x86_64-standard:corretto8"
}

variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))

}

variable "env" {

  type = string
  
  
}