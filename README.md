# ECS Gatus Monitoring Stack

A containerised monitoring application deployed on AWS using ECS Fargate,
provisioned with Terraform, and delivered through a CI/CD pipeline.

---
## Overview

This project demonstrates a complete end-to-end deployment of a containerised application in AWS.

It includes infrastructure provisioning, container build and deployment, secure networking, and real-time monitoring.

The application is deployed behind an Application Load Balancer, runs in private subnets, and is exposed via a custom domain over HTTPS.

---
## Live Application

The application is deployed and accessible via a custom domain.

Real-time monitoring is implemented using Gatus, providing visibility into uptime, response times, and system health.

![App Demo](screenshots/app-demo.gif)

---
### HTTPS Validation

The application is served over HTTPS using AWS Certificate Manager.

![HTTPS Certificate](screenshots/https-certificate-valid.png)

---
## Key Features

- ECS Fargate deployment (serverless containers)
- Multi-AZ architecture across two Availability Zones
- Private subnet isolation for application tasks
- Application Load Balancer for controlled ingress
- NAT Gateway for outbound internet access
- CI/CD pipeline using GitHub Actions
- Docker image build and push to Amazon ECR
- Infrastructure as Code using Terraform
- Remote Terraform state stored in S3 with locking
- HTTPS enabled via AWS Certificate Manager
- Real-time monitoring with Gatus
---
## Key Outcomes

- Reduced Docker image size from ~2.45GB (single-stage build including toolchain and dependencies) to ~58MB using a multi-stage build, removing unnecessary build artifacts from the final runtime image

- Automated image build, scan, and deployment through GitHub Actions, eliminating manual deployment steps and ensuring consistent releases

- Integrated Trivy image scanning into the CI pipeline to surface vulnerabilities before images are pushed to ECR

- Deployed a production-style architecture with private subnet isolation, ALB-managed HTTPS (TLS 1.3), HTTP to HTTPS redirection, and multi-AZ resilience
---

## Architecture

![Architecture Diagram](screenshots/architecture-diagram.png)

---

## Architecture Overview

The application is deployed in AWS across two Availability Zones to improve resilience and availability.

User traffic is routed through Route53 to a custom domain, which resolves to an Application Load Balancer. HTTPS is enabled using AWS Certificate Manager.

The load balancer distributes incoming requests to ECS Fargate tasks running in private subnets. These tasks are not directly exposed to the internet, ensuring a secure architecture where all inbound traffic is controlled through the load balancer.

The VPC is split into public and private subnets:

- Public subnets host the Application Load Balancer and NAT Gateway  
- Private subnets host ECS tasks  

Outbound internet access from ECS tasks, such as pulling container images from ECR, is handled via the NAT Gateway. This allows the tasks to communicate externally without being publicly accessible.

The application container is built and pushed to Amazon ECR through a CI/CD pipeline using GitHub Actions. Terraform is used to provision and manage all infrastructure, with remote state stored in S3 for consistency and state locking.

Monitoring is implemented using Gatus, providing real-time visibility into application health, response times, and uptime.

This architecture separates public and private resources, enforces
controlled access, and is deployed across two Availability Zones.


## Pipeline Execution

The CI/CD pipelines are fully operational and handle the build, deployment, and teardown of infrastructure.

### Build and Push Pipeline

Builds the Docker image and pushes it to Amazon ECR.

![Build and Push](screenshots/pipeline-build-v2.png)

---

### Deploy Pipeline

Runs Terraform to provision and update infrastructure, including ECS services.

Terraform variables are dynamically injected via environment variables in the CI pipeline, including the container image tag and infrastructure configuration.

![Deploy Pipeline](screenshots/pipeline-deploy.png)

---

### Destroy Pipeline

Tears down infrastructure when required.

![Destroy Pipeline](screenshots/pipeline-destroy.png)

## Project Structure

```text
.
├──app/                      
├── bootstrap/                
├── infra/
│   ├── modules/              
│   │   ├── acm/
│   │   ├── alb/
│   │   ├── ecs/
│   │   ├── route53/
│   │   └── vpc/
│   ├── backend.tf            
│   ├── provider.tf           
│   ├── variables.tf          
│   ├── outputs.tf            
│   └── main.tf               
├── .github/workflows/        
├── screenshots/               
├── Dockerfile                
```

## Docker Improvements

The application uses a multi-stage Docker build to ensure the final image only contains what is necessary, reducing image size.

The runtime container is configured to run as a non-root user, following the principle of least privilege and reducing the impact of a potential container compromise.

File ownership is explicitly set to ensure the application has the correct permissions when running as a non-root user.

## Security Considerations

- ECS tasks run in private subnets with no public IP addresses
- Security groups use SG-to-SG rules, ECS only accepts traffic from
  the ALB security group, not open CIDR ranges
- HTTP redirected to HTTPS via ALB 301 redirect
- HTTPS enforced via ACM with TLS 1.3 policy
- OIDC authentication for GitHub Actions, no static AWS keys in CI/CD
- Terraform state stored remotely in S3 with native state locking

## How to Reproduce This Project

Note: This project incurs AWS costs while running. Tear down
infrastructure when not in use.

### Prerequisites

- Terraform >= 1.14
- AWS CLI configured with appropriate permissions
- A registered domain with a subdomain delegated to Route53
- GitHub repository with the following secrets configured:

| Secret | Description |
|---|---|
| `AWS_ROLE_ARN` | IAM role ARN for OIDC authentication |
| `TF_VAR_hosted_zone_id` | Route53 hosted zone ID |
| `TF_VAR_ECR_REPOSITORY_URL` | Full ECR repository URL |

### 1. Clone the repository

```bash
git clone https://github.com/Mohamed-Abdullahi1/gatus-ecs-project.git
cd gatus-ecs-project
```

### 2. Bootstrap the state backend

The S3 bucket for Terraform state must exist before deploying
infrastructure.

```bash
cd bootstrap
terraform init
terraform apply
```

### 3. Deploy via CI/CD

Push to main to trigger the pipelines automatically, or trigger
manually via workflow_dispatch in the Actions tab.

Infrastructure is managed through the CI/CD pipeline. Manual
terraform apply is not recommended.

### 4. Tear down

Trigger the destroy pipeline manually via workflow_dispatch in
the Actions tab.