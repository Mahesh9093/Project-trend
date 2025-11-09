terraform {


enable_nat_gateway = true
single_nat_gateway = true
}


data "aws_availability_zones" "available" {}


# 2) EKS
module "eks" {
source = "terraform-aws-modules/eks/aws"
version = "~> 20.0"


cluster_name = var.cluster_name
cluster_version = "1.29"


vpc_id = module.vpc.vpc_id
subnet_ids = module.vpc.private_subnets


cluster_endpoint_public_access = true
cluster_endpoint_private_access = false


eks_managed_node_groups = {
default = {
desired_size = 2
min_size = 2
max_size = 4
instance_types = ["t3.medium"]
labels = { role = "worker" }
}
}
}


# 3) Jenkins EC2 (public subnet)
resource "aws_security_group" "jenkins_sg" {
name = "jenkins-sg"
description = "Allow SSH and Jenkins"
vpc_id = module.vpc.vpc_id


ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}


resource "aws_instance" "jenkins" {
ami = var.jenkins_ami
instance_type = var.jenkins_instance_type
subnet_id = module.vpc.public_subnets[0]
vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
key_name = var.key_name


user_data = <<-EOF
#!/bin/bash
set -e
apt-get update -y
apt-get install -y openjdk-17-jdk docker.io awscli kubectl
systemctl enable docker && systemctl start docker


# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update -y && apt-get install -y jenkins
usermod -aG docker jenkins
systemctl enable jenkins && systemctl start jenkins


# eksctl (optional)
curl -sLO https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz
tar -xzf eksctl_*_amd64.tar.gz -C /usr/local/bin


# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash


echo "Jenkins is installing; access on port 8080"
EOF


tags = { Name = "jenkins-trend" }
}


