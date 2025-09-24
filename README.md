📦 Application Deployment – Trend E-commerce Website

1. Project Overview
This project demonstrates the end-to-end deployment of a React application in a production-ready state using Docker, Terraform, Jenkins, Kubernetes (EKS), and monitoring tools.
Application Repo: Trend GitHub Repo
Deployment Target: AWS EKS with LoadBalancer Service
CI/CD: Jenkins Pipeline integrated with GitHub Webhooks
Monitoring: Prometheus & Grafana
Code pushed to GitHub triggers Jenkins pipeline.

 2. Architecture Diagram
<img width="2424" height="1592" alt="image" src="https://github.com/user-attachments/assets/c6094d18-b71c-45a9-993c-9e235e10e430" />



Jenkins builds Docker image and pushes to DockerHub.
Jenkins deploys the application to EKS using kubectl.
Application exposed via LoadBalancer.
Cluster health monitored via Prometheus + Grafana.

 3. Cloning repo and push to Github
   
   CLone the repo /dist and push it to github by  crweating the new repo.
   Adding the required file like Docekrfile, deployment.yml and service.yml
   creating jenkins file for CI/CD

 4.Terraform – Infrastructure Provisioning

  creating infrastructure using the terraform.Below are the service creation using single  the main.tf provisions
  VPC
  IAM Role
  EC2 Instance with terraform
  AWS EKS Cluster 

 DockerHub Setup
       Created repository: dockerhub_username/trend-app
       Jenkins pipeline pushes built image here.
    Kubernetes Deployment
      creating  a folder of K8s adding  deployment.yml  and service yml
 5.Jenkins CI/CD   
      Installed plugins: Docker, Git, Kubernetes, Pipeline.
      Configured GitHub Webhook.
      Declarative pipeline (Jenkinsfile):

5. Monitoring Setup
    Installed Prometheus for metrics collection.
    Installed Grafana for visualization.
    Created dashboards to monitor:
    Pod health
    Node resource usage







