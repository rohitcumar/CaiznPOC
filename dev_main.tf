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

variable "jenkins_user_data" {
  default = <<-EOF
              #!/bin/bash
              sudo yum install -y java
              sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
              sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
              sudo yum install -y jenkins
              sudo systemctl start jenkins
              sudo systemctl enable jenkins

              
              sudo amazon-linux-extras install docker -y
              sudo systemctl start docker
              sudo systemctl enable docker

              
              sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
              sudo chmod +x kubectl
              sudo mv kubectl /usr/local/bin/

              
              curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
              chmod +x get_helm.sh
              ./get_helm.sh
            EOF
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
