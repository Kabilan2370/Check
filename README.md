### Deploy Strapi on EC2 using Terraform and Docker, Everything should still be automated via Terraform.

### 🟢 Step 1: here I already created a strapi as a docker image using dockerfile and stored on my dickerHub.
I haven't use my AWS ECR repo because of this.

### 🟢 Step 2: I created a individual AWS vpc, subnet, route and security groups for this deployment through terraform.

![Alt Text](./1.png)

### 🟢 Step 3: While launch the ec2 machine it will automatically install the docker and neccessary dependies. So, I mention the installation instructions on usedata.sh

### 🟢 Step 4: For this strapi deployment I used t3.small 2cpu and 2 GB ram and additionally installed 4 GB swapfile. 

### 🟢 Step 5: Launch a another container for strapi with the neccessary credentials and connect the postgresql.













