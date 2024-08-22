


# writing all needed permission policy for role

data "aws_iam_policy_document" "codebuild_permission_policy" {

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:InitiateLayerUpload",
      "ecr:BatchGetImage",
      "ecr:UploadLayerPart", // Added for uploading layers
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

}


# writing a trust policy for role 
data "aws_iam_policy_document" "assume_role" {

  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com"
      ]

    }

    actions = ["sts:AssumeRole"]
  }

}


# creating and attaching trust policy to role
resource "aws_iam_role" "codeBuildRole" {
  name               = "${var.env}_codeBuildRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

}

# saving the policy to aws account and generated  the arn will futher  attach in role
resource "aws_iam_policy" "codebuild_permission_policy" {
  name   = "${var.env}_codebuild_permission_policy"
  policy = data.aws_iam_policy_document.codebuild_permission_policy.json
}


# attaching the permission policy to role  
resource "aws_iam_role_policy_attachment" "codebuild_role_policy_attachment" {
  role       = aws_iam_role.codeBuildRole.name
  policy_arn = aws_iam_policy.codebuild_permission_policy.arn
}


# writing the plocies for the role to have persmison for various resources

resource "aws_codebuild_project" "codebuild_project" {


  name               = var.projectName
  build_timeout      = var.build_timeout
  project_visibility = "PRIVATE"
  service_role       = aws_iam_role.codeBuildRole.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {

    compute_type                = var.compute_type
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false


    dynamic "environment_variable" {
      for_each = var.environment_variables

      content {

        name  = environment_variable.value.name
        value = environment_variable.value.value

        # Include the "type" attribute if it exists in the object
        # type  = try(environment_variable.value.type, null)
      }
    }

  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"

    }
  }

  description = var.codeBuildDes

  source {

    buildspec       = var.codeBuildSourceBuildspec
    type            = "GITHUB"
    location        = var.SourceUrl
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = false
    }

  }

}
