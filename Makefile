# 📦 Compose files
SONAR_COMPOSE=docker-compose.yaml
POSTGRES_COMPOSE=../postgres/docker-compose.yaml

# 🎯 Targets
.PHONY: up down build logs clean pg-up pg-down

## 🟢 Start SonarQube
up:
	docker compose -f $(POSTGRES_COMPOSE) -f $(SONAR_COMPOSE) up -d postgres_sonar
	sleep 5
	docker compose -f $(POSTGRES_COMPOSE) -f $(SONAR_COMPOSE) up -d sonarqube

## 🔴 Stop SonarQube
down:
	docker compose -f $(SONAR_COMPOSE) down

build:
	docker compose -f $(SONAR_COMPOSE) build

logs:
	docker compose -f $(SONAR_COMPOSE) logs -f sonarqube

clean:
	docker compose -f $(SONAR_COMPOSE) down -v --remove-orphans

## 🟢 Start only postgres_sonar service
pg-up:
	docker compose -f $(POSTGRES_COMPOSE) up -d postgres_sonar

## 🔴 Stop only postgres_sonar service
pg-down:
	docker compose -f $(POSTGRES_COMPOSE) stop postgres_sonar