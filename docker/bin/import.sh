#!/bin/bash

export DOCKER_CONTAINER=sqlenterprise
export SA_PASSWORD="<YourStrong!Passw0rd>"
export EXPORT_DB=elements

/usr/bin/env docker exec \
  --interactive \
  --tty \
  $DOCKER_CONTAINER \
  /opt/mssql-tools/bin/sqlcmd \
  -S localhost \
  -U SA \
  -P $SA_PASSWORD \
  -Q "DROP DATABASE $EXPORT_DB; CREATE DATABASE $EXPORT_DB;"

EXPORT_DIR=$1
if [ -z "$EXPORT_DIR" ]
then
  echo "Usage: import.sh /path/to/export/dir/"
else
  export EXPORT_DIR=exports/
  for EXPORT in `ls $EXPORT_DIR/*bcp | sed 's/exports\\/\\///' | sed 's/\.bcp//'`
  do
    EXPORT_SCHEMA="${EXPORT}_schema.xml"
    EXPORT_FILE="${EXPORT}.bcp"
    EXPORT_TABLE="${EXPORT//elements_dbo_/}"

    echo "Importing the table ${EXPORT_TABLE} from ${EXPORT_FILE} using ${EXPORT_SCHEMA}..."

    /usr/bin/env docker exec \
      --interactive \
      --tty \
      $DOCKER_CONTAINER \
      /opt/mssql-tools/bin/bcp \
      $EXPORT_TABLE in "/exports/$EXPORT_FILE" \
      -f $EXPORT_SCHEMA \
      -d $EXPORT_DB \
      -S localhost \
      -U SA \
      -P $SA_PASSWORD

  done
fi