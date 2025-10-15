FROM quay.io/keycloak/keycloak:26.0.2

COPY drivers/mssql-jdbc-13.2.0.jre11.jar /opt/keycloak/providers/
COPY realms/realm-export.json /opt/keycloak/data/import/
COPY themes/storefront-theme /opt/keycloak/themes/storefront-theme
COPY themes/backoffice-theme /opt/keycloak/themes/backoffice-theme

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

EXPOSE 8080

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm"]