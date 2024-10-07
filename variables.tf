variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "ami" {
  description = "AMI ID for Red Hat Linux"
  default     = "ami-0583d8c7a9c35822c"  # Update with your region-specific AMI
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
    description = "The name of the SSH key pair to use for this instance"
    default = "coalfire"
  
}