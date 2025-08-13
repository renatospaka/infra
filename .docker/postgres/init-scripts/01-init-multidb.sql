-- Initialization script for multidatabase PostgreSQL setup
-- Create databases: sonarqube, keycloak
-- Create users: sonar, keycloak
-- Set passwords

CREATE DATABASE sonarqube;
CREATE DATABASE keycloak;

\connect dummy

-- Create users and grant privileges
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'dummy') THEN
        CREATE ROLE dummy LOGIN PASSWORD 'ThisIsLocal-NoNeed2Worry!';
    END IF;
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'sonar') THEN
        CREATE ROLE sonar LOGIN PASSWORD 'ThisIsLocal-NoNeed2Worry!';
    END IF;
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'keycloak') THEN
        CREATE ROLE keycloak LOGIN PASSWORD 'ThisIsLocal-NoNeed2Worry!';
    END IF;
END$$;

-- Grant privileges on databases
GRANT ALL PRIVILEGES ON DATABASE dummy TO dummy;
GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonar;
GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak;

\connect sonarqube
GRANT ALL PRIVILEGES ON SCHEMA public TO sonar;

\connect keycloak
GRANT ALL PRIVILEGES ON SCHEMA public TO keycloak;
