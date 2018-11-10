#!/bin/ash

ssh-keygen -A

mkdir -p /data
touch /var/log/messages ; chmod 666 /var/log/messages

/usr/sbin/sshd

rsyslogd

tail -f /var/log/messages
