# Cloud Local Infrastructure

This project provisions a self-contained local infrastructure, simulating a cloud environment. The containerized setup includes a PostgreSQL database and SonarQube, designed to support code quality analysis and development.

⚠️ WARNING: This project is for development purposes only. Do not use this environment in QA, homologation, or production.

## 🏗️ Services

- **PostgreSQL 14** (14.15-alpine3.21) - Database server
- **SonarQube** (2025.4.2-developer) - Code quality and security analysis platform

## 🚀 Quick Start

```bash
# Start all services
make up

# Stop all services  
make down
```

## 📋 Available Commands

### Main Operations
- `make up` - Start all services with dependency management
- `make cloud` - Start services with force recreate (cloud deployment)
- `make down` - Stop all services
- `make build` - Build all images
- `make clean` - Stop services and remove volumes/orphans

### Individual Service Management
- `make postgres-up` / `make postgres-down` - PostgreSQL service control
- `make sonar-up` / `make sonar-down` - SonarQube service control
- `make stop-postgres` / `make stop-sonar` - Alternative stop commands

### Monitoring
- `make logs` - Follow SonarQube logs

## 🌐 Service Access

- **SonarQube**: http://localhost:9000
- **PostgreSQL**: localhost:3500

## 🗃️ Database Configuration
## 🗃️ Database Configuration

**SonarQube Database:**
- Database: `sonarqube`
- User: `sonar`
- Password: `ThisIsLocal-NoNeed2Worry!`
- Port: `3500`

## 🏷️ Project Naming

All containers and resources are created with the project name `cloud` for easy identification:
- Containers: `cloud-infra_postgres-1`, `cloud-infra_sonar-1`
- Network: `cloud_infra_net`
- Volumes: `cloud_infra_postgres_data`, `cloud_infra_sonarqube_*`

## 🔍 Container Management

```bash
# List project containers
docker ps --filter "label=com.docker.compose.project=cloud"

# Monitor resources
docker stats $(docker ps -q --filter "label=com.docker.compose.project=cloud")
```

## 🏥 Health Checks

- **PostgreSQL**: Ready check via `pg_isready`
- **SonarQube**: HTTP status endpoint check with automatic dependency on PostgreSQL health
