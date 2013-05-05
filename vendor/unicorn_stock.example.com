#!/bin/bash
### BEGIN INIT INFO
# Provides:          unicorn_stock.example.com
# Required-Start:    $all
# Required-Stop:     $network $local_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start the stock.example.com unicorn
# Description:       Enable unicorn of stock.example.com at boot time.
### END INIT INFO
# 
# Use this as a basis for your own Unicorn init script.
# Make sure that all paths are correct.

set -u
set -e

# CHANGE HERE TO YOUR APP
APP_USER="stock.example.co:"	# user under which you have installed the app
RUBY_VERSION="ruby-1.9.3-p194"	# need to match your ${APP_USER} rvm default ruby
ENV=production			# probably leave this
# DONT TOUCH UNDER THIS

USER_ROOT="/home/${APP_USER}"
APP_ROOT="${USER_ROOT}/electrostock"
PID="${APP_ROOT}/tmp/pids/unicorn.pid"

GEM_HOME="${USER_ROOT}/.rvm/gems/${RUBY_VERSION}"

UNICORN_OPTS="-D -E $ENV -c ${USER_ROOT}/unicorn.rb"

SET_PATH="cd $APP_ROOT; source ../.rvm/scripts/rvm; rvm use ${RUBY_VERSION}; export GEM_HOME=$GEM_HOME"
CMD="$SET_PATH; bundle exec unicorn $UNICORN_OPTS"

old_pid="$PID.oldbin"

cd $APP_ROOT || exit 1

sig () {
	test -s "$PID" && kill -$1 `cat $PID`
}

oldsig () {
	test -s $old_pid && kill -$1 `cat $old_pid`
}

case ${1-help} in
start)
	sig 0 && echo >&2 "Already running" && exit 0
	su - ${APP_USER} -c "$CMD"
	;;
stop)
	sig QUIT && exit 0
	echo >&2 "Not running"
	;;
force-stop)
	sig TERM && exit 0
	echo >&2 "Not running"
	;;
restart|reload)
	sig HUP && echo reloaded OK && exit 0
	echo >&2 "Couldn't reload, starting '$CMD' instead"
	su - ${APP_USER} -c "$CMD"
	;;
upgrade)
	sig USR2 && exit 0
	echo >&2 "Couldn't upgrade, starting '$CMD' instead"
	su - ${APP_USER} -c "$CMD"
	;;
rotate)
	sig USR1 && echo rotated logs OK && exit 0
	echo >&2 "Couldn't rotate logs" && exit 1
	;;
*)
 	echo >&2 "Usage: $0 <start|stop|restart|upgrade|rotate|force-stop>"
 	exit 1
 	;;
esac

