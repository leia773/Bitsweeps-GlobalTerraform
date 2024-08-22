

output "codebuild_project_arn" {
  description = "ARN of the created CodeBuild project"
  value       = aws_codebuild_project.codebuild_project.arn
}

