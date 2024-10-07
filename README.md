# Terraform AWS VPC, EC2, ASG, ALB, and S3 Setup

## This Terraform project provisions an AWS infrastructure that includes the following:

* A Virtual Private Cloud (VPC) with public and private subnets
* EC2 instances in a public subnet
* Auto Scaling Group (ASG) in private subnets with Apache installed
* Application Load Balancer (ALB) for traffic distribution
* S3 buckets with lifecycle policies for images and logs
* IAM roles and policies for managing access
  
## Requirements

* Terraform 1.0+
* AWS Account and credentials configured
* You can configure credentials using AWS CLI:
	```bash
		aws configure
* Access to Red Hat Linux AMI (update the ami_id variable if needed)
* SSH access for the EC2 instance
## AWS Resources Created

1.	VPC (10.1.0.0/16):
* 4 subnets across two availability zones
* 10.1.0.0/24 (Public Subnet 1 - AZ1)
* 10.1.1.0/24 (Public Subnet 2 - AZ2)
* 10.1.2.0/24 (Private Subnet 1 - AZ1)
* 10.1.3.0/24 (Private Subnet 2 - AZ2)

2.	EC2 Instance:
* Runs in Public Subnet 2 (10.1.1.0/24)
* Instance Type: t2.micro
* 20 GB EBS storage
* Security group allowing HTTP (80) and SSH (22) access from anywhere

3.	Auto Scaling Group (ASG):
* Instances in Private Subnets (10.1.2.0/24, 10.1.3.0/24)
* Min 2, Max 6 instances
* 20 GB EBS storage per instance
* Apache HTTP server automatically installed via user-data script

4.	Application Load Balancer (ALB):
* Listens on port 80 (HTTP) and forwards traffic to ASG instances on port 443 (HTTPS)

5.	S3 Buckets:
* Images bucket with lifecycle rules:
* Moves objects in Memes/ folder older than 90 days to Glacier
* Logs bucket with two folders and lifecycle rules:
* Moves objects older than 90 days in Active/ folder to Glacier
* Deletes objects older than 90 days in Inactive/ folder

6.	IAM Roles:
* EC2 instances in the ASG can read from the Images S3 bucket
	* All EC2 instances can write logs to the Logs S3 bucket
## Usage

1. Initializing terraform and applying resources
   	```bash
	git clone "https://github.com/JustinPaneto/coalfire-assessment"
  	cd "coalfire-assessment"
	terraform init
	terraform validate
	terraform plan
  	terraform apply
2.  Destroy the resources
   ```bash
		terraform destroy
