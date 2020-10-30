  
#!/bin/bash
AIRPAL_ALIAS="my-airpal"
AIRPAL_TAG="latest"

cdir="`dirname "$0"`"
cdir="`cd "$cdir"; pwd`"

[[ "$TRACE" ]] && set -x

_log() {
  [[ "$2" ]] && echo "[`date +'%Y-%m-%d %H:%M:%S.%N'`] - $1 - $2"
}

info() {
  [[ "$1" ]] && _log "INFO" "$1"
}

warn() {
  [[ "$1" ]] && _log "WARN" "$1"
}

setup_env() {
  info "Load environment variables from $cdir/airpal-env.sh..."
  if [ -f $cdir/airpal-env.sh ]
  then
    . "$cdir/airpal-env.sh"
  else
    warn "Skip airpal-env.sh as it does not exist"
  fi

  # check environment variables and set defaults as required
  : ${USER_TIMEZONE:="UTC"}
  : ${MYSQL_HOST:="mysql"}
  : ${MYSQL_PORT:="3306"}
  : ${MYSQL_DB:="airpal"}
  : ${MYSQL_USER:="airpal"}
  : ${MYSQL_PASSWD:="airpal"}
  : ${PRESTO_SERVER_URI:="http://presto:8080"}

  info "Loaded environment variables:"
  info "	MYSQL_HOST        = $MYSQL_HOST"
  info "	MYSQL_PORT        = $MYSQL_PORT"
  info "	MYSQL_DB          = $MYSQL_DB"
  info "	MYSQL_USER        = $MYSQL_USER"
  info "	MYSQL_PASSWD      = ***"
  info "	USER_TIMEZONE     = $USER_TIMEZONE"
  info "	PRESTO_SERVER_URI = $PRESTO_SERVER_URI"
}

start_airpal() {
  info "Stop and remove \"$AIRPAL_ALIAS\" if it exists and start new one"
  # stop and remove the container if it exists
  docker stop "$AIRPAL_ALIAS" >/dev/null 2>&1 && docker rm "$AIRPAL_ALIAS" >/dev/null 2>&1

  # use --privileged=true has the potential risk of causing clock drift
  # references: http://stackoverflow.com/questions/24288616/permission-denied-on-accessing-host-directory-in-docker
  docker run -d --name="$AIRPAL_ALIAS" --net=host --restart=always \
    -e MYSQL_HOST="$MYSQL_HOST" -e MYSQL_PORT="$MYSQL_PORT" -e MYSQL_DB="$MYSQL_DB" \
    -e MYSQL_USER="$MYSQL_USER" -e MYSQL_PASSWD="$MYSQL_PASSWD" \
    -e USER_TIMEZONE="$USER_TIMEZONE" -e PRESTO_SERVER_URI="$PRESTO_SERVER_URI" \
    zhicwu/airpal:$AIRPAL_TAG

  info "Try 'docker logs -f \"$AIRPAL_ALIAS\"' to see if this works"
}

main() {
  setup_env
  start_airpal
}
