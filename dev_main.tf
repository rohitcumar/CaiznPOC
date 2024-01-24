provider "aws" {
  region = "ap-south-1"  
}


variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

module "vpc" {
  source = "../modules/vpc"

  cidr_block          = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}


variable "jenkins_ami" {
  default = "ami-xxxxxxxxxxxxxxxxx"  
}

variable "key_pair" {
  default = "your-key-pair"  
}

module "jenkins_instance" {
  source = "../modules/jenkins_instance"

  ami         = var.jenkins_ami
  instance_type = "t2.micro"  
  key_name    = var.key_pair
}
