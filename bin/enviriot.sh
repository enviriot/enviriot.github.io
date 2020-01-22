#! /bin/sh
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

ret=$(ps ax | grep "enviriot.exe" | grep -v "grep" | wc -l)

case "$1" in
 start)
  if [ $ret -eq 0 ]; then
   echo "Starting Enviriot"
   ${MONOSERVER} -d:${ENVIRIOT_FOLDER}/bin -l:${ENVIRIOT_PID} ${ENVIRIOT_FOLDER}/bin/enviriot.exe
  else
   echo "Enviriot Service is already running!"
  fi
 ;;
 stop)
  if [ $ret -eq 0 ]; then
   echo "Enviriot Service is not running"
  else
    echo "Stopping Enviriot Service"
    kill $(pgrep -f enviriot.exe)
    rm ${ENVIRIOT_PID}
  fi
 ;;
 status)
  if [ $ret -eq 0 ]; then
   echo "Enviriot Service is not running"
   exit 3
  else
   echo "Enviriot Service is running"
   exit 0
  fi
 ;;
 restart)
  $0 stop
  sleep 5
  $0 start
  stat_done
 ;;
 *)
  echo "usage: $0 {start|stop|status|restart}"
esac

exit 0
