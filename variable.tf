variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "jenkins_ami" {
  description = "AMI ID for Jenkins instance"
  default     = "ami-xxxxxxxxxxxxxxxxx"
}

variable "key_pair" {
  description = "Key pair for EC2 instances"
  default     = "your-key-pair"
}

variable "instance_type" {
  description = "Instance type for Jenkins EC2 instance"
  default     = "t2.micro"
}
