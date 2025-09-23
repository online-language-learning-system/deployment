#!/bin/bash
# Script Bash (Linux/Bash)

set -e   # Stop script when error happens

SERVER="mssql,1433"
USER="sa"
PASSWORD='6$3S6zPKpJ+Y2-*J'
DB="master"

echo "LOG: Waiting for SQL Server running..."

# Open run-initialization.sh with Notepad++
# Menu Edit → EOL Conversion → UNIX (LF)
# Save file

until /opt/mssql-tools/bin/sqlcmd -S $SERVER -U $USER -P "$PASSWORD" -d $DB -Q "SELECT 1" > /dev/null 2>&1
do
  sleep 2
done
echo "LOG: SQL Server is ready..."

echo "LOG: Executing SQL file initialization..."
for file in /opt/mssql_scripts/*.sql;
do
  echo "LOG: Running $file..."
  /opt/mssql-tools/bin/sqlcmd -S $SERVER -U $USER -P "$PASSWORD" -d $DB -i "$file"
done

echo "LOG: Database initialization completed."
