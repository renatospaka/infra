CLOUD_COMPOSE=docker-compose.yaml

#
# General/All Services
.PHONY: build build-and-up cloud up down clean

## Build all services
build:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) build

## Build and start all services
build-and-up:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) up --build --force-recreate

## Start compose with cloud flag
cloud:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) up --force-recreate

## Start all services
up:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) up

## Stop all services
down:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) down

## Remove containers, volumes, and orphans
clean:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) down -v --remove-orphans

#
# Multidatabase/Postgres (infra_postgres_multi)
.PHONY: postgres-up postgres-down postgres-stop postgres-status postgres-logs \
        postgres-clean-all postgres-clean-all-with-images \
				postgres-force-clean

## Start only multidatabase postgres service
postgres-up:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) up -d infra_postgres_multi

## Stop only multidatabase postgres service
postgres-down:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) stop infra_postgres_multi

## Stop multidatabase postgres service (alias)
postgres-stop:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) stop infra_postgres_multi

## Show status of multidatabase postgres container
postgres-status:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) ps infra_postgres_multi

## Show logs of multidatabase postgres container
postgres-logs:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) logs -f infra_postgres_multi

## Stop multidatabase postgres container and remove volumes (WARNING: deletes all data)
postgres-clean-all:
	@read -p "Are you sure? Type 'yes' to continue: " confirm && [ "$$confirm" = "yes" ] || exit 1
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) down infra_postgres_multi
	docker volume rm infra_postgres_multi_data 2>/dev/null || true

## Stop multidatabase postgres container, remove volumes AND images (WARNING: complete cleanup)
postgres-clean-all-with-images:
	@read -p "Are you absolutely sure? Type 'yes' to continue: " confirm && [ "$$confirm" = "yes" ] || exit 1
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) down infra_postgres_multi
	docker volume rm infra_postgres_multi_data 2>/dev/null || true
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) down --rmi all 2>/dev/null || true
	docker image rm cloud-infra_postgres_multi 2>/dev/null || true
	docker volume prune -f

## Force remove multidatabase postgres volume (stops/removes containers, then removes volume)
postgres-force-clean:
	@read -p "Are you sure? Type 'yes' to continue: " confirm && [ "$$confirm" = "yes" ] || exit 1
	docker compose --project-name=cloud down
	docker volume rm cloud_infra_postgres_multi_data
	docker volume prune -f

#
# Multidatabase/Postgres (infra_postgres_multi) connection to databases
.PHONY: database-keycloak-connect database-sonar-connect

## Connect to Keycloak database (in multidatabase)
database-keycloak-connect:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) exec infra_postgres_multi psql -U keycloak -d keycloak

## Connect to sonarqube database (in multidatabase)
database-sonar-connect:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) exec infra_postgres_multi psql -U sonar -d sonarqube

#
# SonarQube (infra_sonar)
.PHONY: sonar-up sonar-down sonar-logs sonar-connect

## Start only SonarQube service
sonar-up:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) up -d infra_sonar

## Stop only SonarQube service
sonar-down:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) stop infra_sonar

## Show SonarQube logs
sonar-logs:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) logs -f infra_sonar

## Connect to SonarQube container (shell)
sonar-connect:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) exec -it infra_sonar /bin/bash

#
# Keycloak (infra_keycloak)
.PHONY: keycloak-up keycloak-down keycloak-logs keycloak-connect

## Start only Keycloak service
keycloak-up:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) up -d infra_keycloak

## Stop only Keycloak service
keycloak-down:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) stop infra_keycloak

## Show Keycloak logs
keycloak-logs:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) logs -f infra_keycloak

## Connect to Keycloak container (shell)
keycloak-connect:
	docker compose --project-name=cloud -f $(CLOUD_COMPOSE) exec -it infra_keycloak /bin/bash
