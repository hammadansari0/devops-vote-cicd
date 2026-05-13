# 🚀 Three-Tier Web Application

A complete three-tier web application built using modern DevOps practices and containerized infrastructure.

This project demonstrates:

- Frontend deployment
- Backend/API deployment
- Database deployment
- Docker containerization
- Kubernetes orchestration
- Jenkins CI/CD automation

---

# 📌 Project Overview

The application is structured into multiple services:

| Service | Description |
|----------|-------------|
| `web` | Frontend application |
| `api` | Backend API service |
| `db` | PostgreSQL database |

The project is designed to run inside Kubernetes and can be automatically deployed using Jenkins pipelines.

---

# ⚙️ Tech Stack

## Frontend
- React / Vue
- Vite

## Backend
- Node.js / Python API

## Database
- PostgreSQL

## DevOps & Infrastructure
- Docker
- Kubernetes
- Jenkins
- GitHub

---

# 📂 Project Structure

```bash
.
├── api/
│   ├── manifests/
│   ├── Dockerfile
│   ├── app.py
│   ├── requirements.txt
│   └── test.py
│
├── db/
│   ├── manifests/
│   ├── README.md
│   ├── database-seed.yaml
│   └── garden.yml
│
├── infra/
│
├── web/
│   ├── manifests/
│   ├── public/
│   ├── src/
│   ├── tests/
│   ├── .browserslistrc
│   ├── .dockerignore
│   └── .editorconfig
│
├── Jenkinsfile
├── docker-compose.yml
└── README.md
```

---

# 🚀 Getting Started

## 📋 Prerequisites

Before running the project, ensure the following tools are installed on your Linux machine:

- Docker
- Kubernetes (Minikube / K3s / Kind / kubeadm)
- kubectl
- Jenkins
- Git
- Node.js
- npm

---

# 🔧 Clone Repository

```bash
git clone https://github.com/your-username/your-repository.git
cd your-repository
```

---

# 🐳 Docker Setup

## Build Docker Images

```bash
docker-compose build
```

## Start Containers

```bash
docker-compose up -d
```

## Verify Running Containers

```bash
docker ps
```

---

# ☸️ Kubernetes Deployment

## Deploy Application Services

Apply application manifests:

```bash
kubectl apply -f app/
```

## Deploy Database

```bash
kubectl apply -f db/manifests/
```

---

# 🔍 Verify Kubernetes Resources

## Check Pods

```bash
kubectl get pods
```

## Check Services

```bash
kubectl get svc
```

## Check Ingress

```bash
kubectl get ingress
```

---

# 🌐 Access Application

If using Minikube:

```bash
minikube service <service-name>
```

Or access through configured ingress hostname/IP.

---

# 🔄 CI/CD Pipeline Setup

This project supports automated CI/CD deployment using Jenkins.

---

# ✅ Requirements for CI/CD Pipeline

To run the CI/CD pipeline successfully, you need:

- Docker installed
- Kubernetes cluster configured
- Jenkins installed on Linux machine
- kubectl configured inside Jenkins server

---

# ⚙️ Jenkins Setup

## Step 1: Install Jenkins

Install Jenkins on your Linux machine.

Start Jenkins service:

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

Check Jenkins status:

```bash
sudo systemctl status jenkins
```

---

# 🔌 Install Required Jenkins Plugins

Install the following plugins from Jenkins Plugin Manager:

- Git Plugin
- Docker Plugin
- Kubernetes Plugin
- Pipeline Plugin

---

# 🔗 Connect GitHub Repository to Jenkins

## Create Jenkins Pipeline Job

1. Open Jenkins Dashboard
2. Click **New Item**
3. Select **Pipeline**
4. Enter project name
5. Click **OK**

---

## Configure GitHub Repository

Under Pipeline section:

- Select:
  ```text
  Pipeline script from SCM
  ```

- SCM:
  ```text
  Git
  ```

- Add your GitHub repository URL.

Example:

```bash
https://github.com/your-username/your-repository.git
```

---

# 🚀 CI/CD Workflow

After setup, the pipeline automatically performs:

```text
GitHub Push
    ↓
Jenkins Trigger
    ↓
Pull Latest Code
    ↓
Run Tests
    ↓
Build Docker Images
    ↓
Deploy to Kubernetes
```

---

# 🧪 Run Tests

## Frontend Tests

```bash
cd app/web
npm install
npm run test
```

## Backend Tests

```bash
cd app/api
npm install
npm run test
```

---

# 🏗 Build Frontend

```bash
cd app/web
npm run build
```

---

# 🐳 Build Docker Images Manually

## Frontend

```bash
docker build -t web-app ./app/web
```

## Backend

```bash
docker build -t api-app ./app/api
```

---

# 📦 Kubernetes Commands

## Restart Deployment

```bash
kubectl rollout restart deployment <deployment-name>
```

## Check Logs

```bash
kubectl logs <pod-name>
```

## Delete Resources

```bash
kubectl delete -f app/
kubectl delete -f db/manifests/
```

---

# 📬 Deployment Notifications

The CI/CD pipeline can be configured to send notifications for:

- Successful builds
- Failed builds
- Deployment URLs
- Pipeline execution logs

Supported notification channels:

- Email
- Slack
- Discord
- Telegram

---

# 🔐 Environment Variables

Create a `.env` file for environment-specific configuration.

Example:

```env
DB_HOST=postgres-service
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=password
API_PORT=5000
```

---

# 📈 Future Improvements

- Helm chart support
- GitHub Actions integration
- Monitoring with Prometheus & Grafana
- Multi-environment deployment
- Auto-scaling with HPA
- GitOps workflow

---

# 🤝 Contributing

Contributions, feature requests, and improvements are welcome.


---

# 👨‍💻 Author

Developed and maintained by Hammad Ansari
