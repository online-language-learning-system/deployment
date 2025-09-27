#!/bin/bash
set -e

SERVER="mssql,1433"
USER="sa"
PASSWORD='6$3S6zPKpJ+Y2-*J'

# Wait until SQL Server is ready
echo "Waiting for SQL Server to start..."
until /opt/mssql-tools/bin/sqlcmd -S $SERVER -U $USER -P "$PASSWORD" -Q "SELECT 1" > /dev/null 2>&1
do
  sleep 2
done
echo "SQL Server is up - running init scripts..."

# Execute all SQL scripts
for file in /opt/mssql/sql_scripts/*.sql;
do
    echo "Running $file..."
    /opt/mssql-tools/bin/sqlcmd -S $SERVER -U $USER -P "$PASSWORD" -i "$file"
done

echo "Initialization complete. Starting SQL Server in foreground..."
wait
