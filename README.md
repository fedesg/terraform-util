# SISORG Infrastructure Project

This project is designed to manage and provision infrastructure using Terraform. The architecture is modular, allowing for scalable and reusable components. Below is the project structure with descriptions of each part.

## Project Structure
```
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   ├── rds/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   ├── ec2/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   ├── iam/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   ├── environments/
│   │   ├── develop/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── terraform.tfvars
│   │   │   ├── outputs.tf
│   │   ├── production/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── terraform.tfvars
│   │   │   ├── outputs.tf
│   ├── providers.tf
│   ├── versions.tf
│   ├── backend.tf
```

## Explanation of the Structure

### `modules/`
This directory contains reusable Terraform modules for different infrastructure components:

- **`vpc/`**: Manages the Virtual Private Cloud (VPC) setup including subnets, route tables, and gateways.
    - `main.tf`: Defines the resources for the VPC.
    - `variables.tf`: Contains variable definitions used by the VPC module.
    - `outputs.tf`: Outputs the VPC-related resources, like VPC ID and subnet IDs.

- **`rds/`**: Manages the Relational Database Service (RDS) instances.
    - `main.tf`: Defines the resources for RDS instances.
    - `variables.tf`: Contains variable definitions for configuring RDS.
    - `outputs.tf`: Outputs details such as the RDS endpoint.

- **`ec2/`**: Manages EC2 instances, including their networking interfaces.
    - `main.tf`: Defines the EC2 instances and associated resources.
    - `variables.tf`: Contains variables for instance types, AMI IDs, and networking.
    - `outputs.tf`: Outputs details such as instance ID and network interface IDs.

- **`iam/`**: Manages IAM roles and policies.
    - `main.tf`: Defines IAM roles and policies needed for the infrastructure.
    - `variables.tf`: Contains variables for IAM configurations.
    - `outputs.tf`: Outputs details like IAM role ARNs.

### `environments/`
This directory separates configurations for different environments (e.g., `develop`, `production`):

- **`develop/`**: Contains Terraform files specific to the development environment.
    - `main.tf`: Calls the modules and passes environment-specific variables.
    - `variables.tf`: Defines environment-specific variables.
    - `terraform.tfvars`: Provides the actual values for the variables in `develop`.
    - `outputs.tf`: Outputs relevant environment-specific resource details.

- **`production/`**: Similar structure to `develop/`, but tailored for the production environment.

### Root Files

- **`providers.tf`**: Configures the cloud providers (e.g., AWS) used in the project.
- **`versions.tf`**: Specifies the required Terraform and provider versions.
- **`backend.tf`**: Configures the backend for storing Terraform state, such as an S3 bucket.

## Getting Started(Linux)

1. **Initialize Terraform:**
   ```bash
   terraform init

2. **Plan the Deployment:**
    ```bash
    AWS_PROFILE=profile terraform plan

3. **Apply the Configuration:**
    ```bash
    AWS_PROFILE=profile terraform plan