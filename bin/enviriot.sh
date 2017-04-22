#!/bin/sh
# Start/stop the enviriot service.
#
### BEGIN INIT INFO
# Provides:          enviriot
# Required-Start:    $network $local_fs $syslog
# Required-Stop:     $network $local_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: enviriot automation system as service
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME=enviriot
DESC="enviriot automation system as service"

MONOSERVER=$(which mono-service)
ENVIRIOT_FOLDER=/opt/enviriot           # <------ CHANGE INSTALL PATH HERE
ENVIRIOT_PID=/var/run/enviriot.pid

case "$1" in
 start)
  if [ -s ${ENVIRIOT_PID} ]; then
   echo "Enviriot Service is already running!"
  else
   echo -n "Starting Enviriot"
   ${MONOSERVER} -d:${ENVIRIOT_FOLDER}/bin -l:${ENVIRIOT_PID} ${ENVIRIOT_FOLDER}/bin/enviriot.exe
  fi
 ;;
 stop)
  if [ -s ${ENVIRIOT_PID} ]; then
   echo -n "Stopping Enviriot Service"
   kill `cat ${ENVIRIOT_PID}`
  else
   echo "Enviriot Service is not running"
  fi
 ;;
 restart)
  $0 stop
  sleep 1
  $0 start
  stat_done
 ;;
 *)
  echo "usage: $0 {start|stop|restart}"
esac

exit 0

