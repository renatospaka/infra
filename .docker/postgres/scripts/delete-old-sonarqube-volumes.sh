
#!/bin/bash

docker volume ls | grep -E 'infra_postgres_data|infra_sonarqube_data|infra_sonarqube_extensions|infra_sonarqube_logs'

docker volume rm infra_postgres_data infra_sonarqube_data infra_sonarqube_extensions infra_sonarqube_logs

docker volume ls | grep -E 'infra_postgres_data|infra_sonarqube_data|infra_sonarqube_extensions|infra_sonarqube_logs'
