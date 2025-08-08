FROM sonarqube:10.4.1-community

ENV SONARQUBE_HOME=/opt/sonarqube
ENV PLUGIN_DIR=${SONARQUBE_HOME}/extensions/plugins

RUN set -eux; \
    curl -fSL https://github.com/SonarOpenCommunity/sonar-go/releases/latest/download/sonar-go-plugin.jar -o ${PLUGIN_DIR}/sonar-go-plugin.jar && \
    curl -fSL https://github.com/SonarOpenCommunity/sonar-plsql/releases/latest/download/sonar-plsql-plugin.jar -o ${PLUGIN_DIR}/sonar-plsql-plugin.jar

EXPOSE 9000

CMD ["bin/sonar.sh", "console"]