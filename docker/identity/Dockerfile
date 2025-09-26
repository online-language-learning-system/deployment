FROM quay.io/keycloak/keycloak:26.0.2

COPY realms/realm-export.json /opt/keycloak/data/import/
COPY themes/storefront-theme /opt/keycloak/themes/olls

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

EXPOSE 8080

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm"]