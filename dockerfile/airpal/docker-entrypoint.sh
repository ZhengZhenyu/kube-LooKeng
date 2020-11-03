#!/bin/bash
set -e

cd $AIRPAL_HOME

if [ "$1" = 'airpal' ]; then
	: ${AIRPAL_HOME:="/airpal"}
	: ${USER_TIMEZONE:="UTC"}

	: ${MYSQL_HOST:="mysql"}
	: ${MYSQL_PORT:="3306"}
	: ${MYSQL_DB:="airpal"}
	: ${MYSQL_USER:="airpal"}
	: ${MYSQL_PASSWD:="airpal"}
	: ${PRESTO_SERVER_URI:="http://presto:8080"}
	
	sed -ri 's/(user:).*/\1 "'"$MYSQL_USER"'"/' "$AIRPAL_HOME/reference.yml"
	sed -ri 's/(password:).*/\1 "'"$MYSQL_PASSWD"'"/' "$AIRPAL_HOME/reference.yml"
	sed -ri 's|(url:).*|\1 "'"jdbc:mysql://$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DB"'"|' "$AIRPAL_HOME/reference.yml"
	sed -ri 's|(prestoCoordinator:).*|\1 "'"$PRESTO_SERVER_URI"'"|' "$AIRPAL_HOME/reference.yml"
fi

airpal db migrate reference.yml

exec "$@"
