## ECS Outline inspired project
- Dockerised app (multi-stage build), pushed images to **ECR**
- Deployed on **ECS Fargate** behind an **ALB** (HTTP/HTTPS) with `/health` checks
- Cloudfront as first point of entry for reduced latency.
- Private **S3 uploads** via **pre-signed URLs**
- **Integrated RDS (Postgres)** for persisted metadata (uploads/invites + future docs)
- **ACM TLS** + **Cloudflare DNS** (DNS validation)
- **Terraform modules** + remote **S3 state backend** with state locking enabled
- **GitHub Actions OIDC** for deploys — **no static AWS keys**

## Architecture Overview

# Users → Internet → CloudFront → ALB → ECS

• Live URL
https://nur-trade.org

• CloudFront is the app entry point
Users hit CloudFront first before traffic is forwarded to the ALB

• The ALB routes traffic to ECS
The load balancer sends requests to ECS tasks running across multiple AZs

• ECS runs in private subnets
The app containers are not exposed directly to the internet

• Public and private subnets are split by role
Public subnets hold the ALB and NAT Gateways
Private subnets hold the app and data layers

• NAT Gateways handle outbound traffic
Private ECS tasks use NAT when they need internet access

• The Internet Gateway connects the VPC to the internet
It supports public subnet connectivity but is not the app entry point

• ECR stores the container images
The application image is stored in ECR for ECS deployments

• GitHub Actions automates build and deployment steps
Workflows build the Docker image, push it to ECR, and run infrastructure changes

• Secrets Manager stores sensitive values
Secrets are injected into ECS at runtime instead of being hardcoded

• RDS stores application data
The database sits privately in the VPC and is only accessed by the app

• One S3 bucket stores app files and uploads
ECS reads from and writes to this bucket during normal app use

• A separate S3 bucket stores Terraform state
This is used for infrastructure management and kept separate from app data

• The design separates app runtime from infrastructure
App traffic, app storage, and Terraform state all have clear boundaries

## Architecture Diagram
<img width="3216" height="3264" alt="image" src="https://github.com/user-attachments/assets/78706bc4-93a7-4f1c-94ad-d46d23cac76e" />


- ## Repo Structure

```text
.
├── .github/
│   └── workflows/
│       ├── push.yaml           # Build & push Docker image to ECR
│       ├── tf.plan.yaml        # Terraform plan (CI)
│       ├── tf.apply.yaml       # Terraform apply (manual, OIDC)
│       └── tf.destroy.yaml     # Terraform destroy (manual cleanup)

├── Docker/
│   ├── Dockerfile              # Production container build
│   ├── docker-compose.yml      # Local dev (optional)
│   └── .dockerignore

├── Infra/
│   ├── main.tf                 # Root module wiring
│   ├── variables.tf            # Root inputs
│   ├── terraform.tfvars        # Local values (do not commit secrets)
│   ├── backend.tf              # Remote S3 state backend (state locking enabled)
│   ├── provider.tf             # Providers (AWS/Cloudflare)
│   └── modules/                # Reusable Terraform modules
│       ├── vpc/                # VPC + public/private subnets
│       ├── sg/                 # Security groups (ALB/ECS/RDS rules)
│       ├── iam/                # ECS task/execution roles + policies (S3/Secrets)
│       ├── ecr/                # ECR repository
│       ├── alb/                # ALB + target group + listeners (80/443)
│       ├── ecs/                # ECS cluster/service/task definition (Fargate)
│       ├── s3/                 # Private uploads bucket
│       ├── acm/                # TLS cert (ACM) + DNS validation
│       ├── rds/                # Postgres (RDS) integration
│       └── cdn/                # Cloudfront integreation for the Caching

├── app/
│   ├── public/                 # Static UI (index + uploads pages)
│   ├── src/server.js           # App server (API + static routes)
│   ├── server.js               # Runtime entry (used by Docker)
│   └── package.json

├── .gitignore                  # Ignore tfstate, .terraform, node_modules, secrets
└── README.md
```
## CI/CD (GitHub Actions)

All workflows are run via **`workflow_dispatch`** (manual triggers) to keep deployments controlled and prevent accidental changes.

### Build & Push (Docker → ECR)
Manual trigger (`workflow_dispatch`):

- Builds the container image (multi-stage Dockerfile)
- Tags the image with the **commit SHA** for traceable releases
- Authenticates to AWS using **GitHub Actions OIDC** (no static AWS keys)
- Pushes the image to **Amazon ECR**

### Terraform Plan
Manual trigger (`workflow_dispatch`) with a confirmation input (e.g. type `PLAN`):

- Runs `terraform fmt -check` to enforce formatting
- Runs `terraform init -input=false` using the remote backend (state in S3)
- Runs `terraform validate` and `tflint` for static checks
- Runs `terraform plan` (non-interactive) to preview changes
- Injects runtime values via `TF_VAR_*` (e.g., Cloudflare token) — not stored in the repo

### Deploy (Terraform Apply)
Manual trigger (`workflow_dispatch`) (confirmation-gated):

- Runs Terraform from `./Infra` (consistent working directory)
- Runs `terraform init` → `terraform plan` → `terraform apply` (non-interactive)
- Uses **OIDC role assumption** for AWS access (no long-lived credentials)

### Terraform Destroy (Cleanup)
Manual trigger (`workflow_dispatch`) for safe teardown:

- Runs `terraform destroy` to remove Terraform-managed AWS resources
- Uses **OIDC** + confirmation gating to prevent accidental deletion
- Keeps the environment reproducible and cost-controlled

- # Build and Push to ECR
<img width="1853" height="962" alt="Screenshot 2026-01-09 150940" src="https://github.com/user-attachments/assets/58d38f9d-31a5-4b25-95ab-c7ecc95bf305" />

# Terraform Plan
<img width="1852" height="969" alt="Screenshot 2026-01-09 000732" src="https://github.com/user-attachments/assets/d47adbf9-0ebb-4d74-8576-4b657f00aaa4" />

# Terraform Apply
  
<img width="1881" height="1013" alt="Screenshot 2026-01-09 150845" src="https://github.com/user-attachments/assets/ae314ab3-1fd1-436d-8e74-04c9f2b90b74" />

# Terrafrom Destroy
  

<img width="1839" height="977" alt="Screenshot 2026-01-09 151207" src="https://github.com/user-attachments/assets/20290287-3bf0-4823-9aa6-63c175516e93" />

# Finished version of the app with my URL

<img width="1866" height="1056" alt="Screenshot 2026-03-06 135034" src="https://github.com/user-attachments/assets/d21ab65c-2e94-48a1-a98f-d6e2153d17b6" />


# Improvments for the future
- When I am modularising my work, have all the security groups for the ALB, RDS etc all in the Security group module and not seperated, half in one and half in another module.
- Track usage, and scale for load.
- Add a bash script that will generate the secrets for the users testing this locally which wiil save time. Instead of typing in the commands to create the secrets.
- Use a VPC Endpoint instead of a NAT Gateway to reduce costs.
- Separate environments (dev/stage/prod) with Terraform workspaces or env folders.
- Blue/Green or Canary deployments instead of pushing to production.
