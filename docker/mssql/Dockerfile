FROM mcr.microsoft.com/mssql/server:2022-latest

USER root
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD='6$3S6zPKpJ+Y2-*J'

# Copy script vào container
COPY ./sql_scripts /docker-entrypoint-initdb.d
COPY ./sql_scripts/run-initialization.sh /run-initialization.sh

RUN chmod +x /run-initialization.sh \
    && chmod -R 755 /docker-entrypoint-initdb.d

# Chạy entrypoint
CMD ["/bin/bash", "/entrypoint.sh"]
