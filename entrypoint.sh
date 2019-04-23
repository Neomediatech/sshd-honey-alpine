#!/bin/bash

LOGS="/var/log/messages"

ssh-keygen -A

touch /var/log/messages ; chmod 666 /var/log/messages

exec rsyslogd &

exec tail -f $LOGS &
exec "$@"
