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
- `make build-and-up` - Build all images and start services
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

## 🎯 Selective Service Management

You can start specific services using the available Make commands:

```bash
# Start only PostgreSQL
make postgres-up

# Start only SonarQube (will automatically start PostgreSQL due to dependency)
make sonar-up

# Stop individual services
make postgres-down
make sonar-down

# Alternative stop commands
make stop-postgres
make stop-sonar
```

**Note:** Due to the `depends_on` configuration, starting SonarQube will automatically start PostgreSQL first, but you can start PostgreSQL independently if you only need the database.

## 🌐 Service Access

- **SonarQube**: http://localhost:9000
- **PostgreSQL**: http://localhost:3400

## 🗃️ Database Configuration
## ➕ Adding a New PostgreSQL Database to the Multidatabase Instance

To add a new database to the `infra_postgres_multi` instance:

1. Edit the initialization script at `.docker/postgres/init-scripts/01-init-multidb.sql` and add a line:
	```sql
	CREATE DATABASE <your_database_name>;
	```
	Optionally, add a user and grant privileges:
	```sql
	DO $$
	BEGIN
		 IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '<your_user>') THEN
			  CREATE ROLE <your_user> LOGIN PASSWORD '<your_password>';
		 END IF;
	END$$;
	GRANT ALL PRIVILEGES ON DATABASE <your_database_name> TO <your_user>;
	```

2. Remove the `cloud_infra_postgres_multi_data` volume to trigger re-initialization:
	```bash
	make postgres-force-clean
	```

3. Rebuild and start the services:
	```bash
	make build-and-up
	```

This will recreate the database and user on the next container startup.
## 🗃️ Database Configuration

**SonarQube Database:**
- Database: `sonarqube`
- User: `sonar`
- Password: `ThisIsLocal-NoNeed2Worry!`
- Port: `3400`

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
