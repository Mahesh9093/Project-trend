📦 Application Deployment – Trend E-commerce Website
1. Project Overview

This project demonstrates the end-to-end deployment of a React application in a production-ready state using Docker, Terraform, Jenkins, Kubernetes (EKS), and monitoring tools.

Application Repo: Trend GitHub Repo

Frontend Port: 3000

Deployment Target: AWS EKS with LoadBalancer Service

CI/CD: Jenkins Pipeline integrated with GitHub Webhooks

Monitoring: Prometheus & Grafana


Code pushed to GitHub triggers Jenkins pipeline.

Jenkins builds Docker image and pushes to DockerHub.
<img width="990" height="482" alt="image" src="https://github.com/user-attachments/assets/31f30044-de77-42ca-90be-3f688c1fc8bc" />

Jenkins deploys the application to EKS using kubectl.

Application exposed via LoadBalancer.

Cluster health monitored via Prometheus + Grafana.
