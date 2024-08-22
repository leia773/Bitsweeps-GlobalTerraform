output "ecr_arn" {

  description = "ARN of the created CodeBuild project"
  value       = aws_ecr_repository.ecr_repo.arn

}

output "registry_id" {
  description = "registry ID where the repository was created."
  value       = aws_ecr_repository.ecr_repo.registry_id

}


output "repository_url" {
  description = "registry url where the repository was created."
  value       = aws_ecr_repository.ecr_repo.repository_url

}
