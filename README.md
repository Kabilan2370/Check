### Deploy Strapi on EC2 using Terraform and Docker, Everything should still be automated via Terraform.

### 🟠 Step 1: here I already created a strapi as a docker image using dockerfile and stored on my dickerHub.
I haven't use my AWS ECR repo because of this.

### 🟠 Step 2: I created a individual AWS vpc, subnet, route and security groups for this deployment through terraform.

Terraform was used to create all required AWS networking resources:

VPC

Public Subnet

Internet Gateway

Route Table & Associations

Security Groups


### 🟠 Step 3: When the EC2 instance is launched, Terraform injects a userdata.sh script that automatically:

Installs Docker and required dependencies

Starts the Docker service

Pulls the Strapi image from Docker Hub

### 🟠 Step 4: For this strapi deployment I used t3.small 2cpu and 2 GB ram and additionally installed 4 GB swapfile. 
The EC2 instance uses:

t3.small (2 vCPUs, 2 GB RAM)

An additional 4 GB swap file created during boot

### 🟠 Step 5: Launch a docker strapi container on 1337 port.
During initialization, a Docker container is launched with:

Port binding (default: 1337)

🟠 terraform commands :

terraform init

terraform validate

terraform plan

terraform apply


