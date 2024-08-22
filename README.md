# Terraform AWS Modules

This repository contains Terraform modules for provisioning AWS resources. Each module represents a specific AWS service or functionality and includes configurations for different environments.

## Modules

### 1. AppRunner

The AppRunner module provisions AWS AppRunner services.

- **Live Environment**: Configuration for the live environment.
- **Test Environment**: Configuration for the test environment.

### 2. CodeBuild

The CodeBuild module provisions AWS CodeBuild projects.

- **Main Configuration**: Main configuration file for the CodeBuild module.
- **Outputs**: Output definitions for the CodeBuild module.
- **Variables**: Input variable definitions for the CodeBuild module.

### 3. ECR

The ECR module provisions AWS Elastic Container Registry repositories.

- **Main Configuration**: Main configuration file for the ECR module.
- **Outputs**: Output definitions for the ECR module.
- **Variables**: Input variable definitions for the ECR module.

## Usage

To use these modules, include them in your Terraform configurations using the `source` attribute:

```hcl
module "example" {
  source = "github.com/your-username/terraform-aws-modules//aws/modules/appRunner/live"
  # Add required variables here
}

## Directory Structure
   ```hcl├── aws
│   └── modules
│       ├── appRunner
│       │   ├── live
│       │   └── test
│       │       ├── main.tf
│       │       ├── outupts.tf
│       │       └── variable.tf
│       ├── codeBuild
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       └── ecr
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf 