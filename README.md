# Kunle Week 9 Task - AWS Infrastructure with Terraform

This Terraform configuration deploys a complete AWS infrastructure setup in the `eu-west-1` region, including a VPC, subnets, security groups, and EC2 instances configured for an Ansible-based infrastructure management scenario.

## Infrastructure Overview

### Architecture Components

- **VPC**: Custom Virtual Private Cloud (`kunle-vpc`) with CIDR block `10.0.0.0/16`
- **Subnets**: Public subnet for hosting EC2 instances
- **Internet Gateway**: Provides internet connectivity to the VPC
- **Route Tables**: Manages traffic routing for public subnets
- **Security Groups**: Controls inbound and outbound traffic for instances
- **EC2 Instances**: Three instances for different purposes:
  - **Nginx Node** (`nginx-node`): Web server instance
  - **Ansible Node** (`ansible-node`): Ansible control node for infrastructure automation
  - **Java Node** (`java-node`): Java application server

### Network Configuration

- VPC CIDR: `10.0.0.0/16`
- Public Subnet CIDR: Configured within VPC range
- Instance Type: `t3.micro` (AWS free tier eligible)
- AMI: Amazon Linux 2 (`ami-09c54d172e7aa3d9a`)
- Region: `eu-west-1`

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13
- AWS Account with appropriate IAM permissions
- AWS CLI configured with credentials (optional but recommended)

## Getting Started

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Review the Execution Plan

```bash
terraform plan
```

### 3. I like to haveeverything together.

```bash
terraform init
terraform fmt
terraform plan
terraform apply -var-file="terraform.tfvars" -auto-approve
```

Terraform will prompt for confirmation before creating resources.

## Configuration Files

 File | Purpose |

 `main.tf`                     - Provider and Terraform version configuration 
 `variable.tf`                 - Variable declarations 
 `terraform.tfvars`            - Variable values and configuration 
 `vpc.tf`                      - VPC resource definition 
 `subnets.tf`                  - Subnet resources 
 `internet-gateway.tf`         - Internet Gateway configuration 
 `route-table.tf`              - Route table definitions 
 `route-table-association.tf`  - Route table associations 
 `security-groups.tf`          - Security group rules 
 `instances.tf`                - EC2 instance definitions 
 `key-name.tf`                 - SSH key pair generation and management 
 `backend.tf`                  - Backend configuration (state management) 
 `output.tf`                   - Output values 

## Key Variables

Edit `terraform.tfvars` to customize your deployment:



## SSH Key Management

The `key-name.tf` file automatically generates an SSH keypair:

- **Private Key**: Stored locally as `{vpc_name}-deployer-key.pem`
- **Public Key**: Uploaded to AWS for instance access
- **Permissions**: Private key file is restricted to read-only (`0400`)

⚠️ **Important**: The private key file is sensitive. Keep it secure and never commit it to version control.

## Outputs

After successful deployment, Terraform outputs the following values:

- `deployer_private_key_pem`: Private SSH key (marked as sensitive)
- `ansible_public_ip`: Public IP address of the Ansible control node
- `ansible_ssh_command`: Ready-to-use SSH command to connect to Ansible instance

### Connect to Ansible Instance

```bash
ssh -i kunle-vpc-deployer-key.pem ec2-user@<ansible-public-ip>
```

Or use the generated SSH command from outputs.

## Cleanup

To remove all resources and avoid unnecessary charges:

```bash
terraform destroy
```

Terraform will prompt for confirmation before destroying resources.

## Notes

- All instances are configured with public IP addresses for easy access
- The Ansible node includes automated Ansible installation via remote-exec provisioner
- Security groups control network access to the instances
- State file management is configured via `backend.tf`

## Support

For issues or questions, refer to the Terraform documentation or AWS documentation for the respective resources.
