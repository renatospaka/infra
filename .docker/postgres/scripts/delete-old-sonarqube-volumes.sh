
#!/bin/bash

docker volume ls | grep -E 'cloud_infra_postgres_data|cloud_infra_sonarqube_data|cloud_infra_sonarqube_extensions|cloud_infra_sonarqube_logs'

docker volume rm cloud_infra_postgres_data cloud_infra_sonarqube_data cloud_infra_sonarqube_extensions cloud_infra_sonarqube_logs

docker volume ls | grep -E 'cloud_infra_postgres_data|cloud_infra_sonarqube_data|cloud_infra_sonarqube_extensions|cloud_infra_sonarqube_logs'
