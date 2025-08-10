# 📦 Compose files
SONAR_COMPOSE=docker-compose.yaml

# 🎯 Targets
.PHONY: up down build logs clean postgres-up postgres-down sonar-up sonar-down cloud stop-postgres stop-sonar

build:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) build

## ☁️ Start compose with cloud flag
cloud:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) up --force-recreate

logs:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) logs -f infra_sonar

## 🟢 Start SonarQube
up:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) up

## 🔴 Stop SonarQube
down:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) down

clean:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) down -v --remove-orphans

## 🟢 Start only postgres service
postgres-up:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) up -d infra_postgres

## 🔴 Stop only postgres service
postgres-down:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) stop infra_postgres

## 🟢 Start only sonar service
sonar-up:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) up -d infra_sonar

## 🔴 Stop only sonar service
sonar-down:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) stop infra_sonar

## 🔴 Stop individual services
stop-postgres:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) stop infra_postgres

stop-sonar:
	docker compose --project-name=cloud -f $(SONAR_COMPOSE) stop infra_sonar
