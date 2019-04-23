FROM alpine:3.9

LABEL maintainer="docker-dario@neomediatech.it"

RUN echo "root:!::0:::::" > /etc/shadow ; echo "root:x:0:0:root:/root:/bin/ash" > /etc/passwd && \
    echo "sshd:!::0:::::" >> /etc/shadow ; echo "sshd:x:22:22:sshd:/dev/null:/sbin/nologin" >> /etc/passwd && \
    apk update && apk upgrade && apk add --no-cache tzdata && cp /usr/share/zoneinfo/Europe/Rome /etc/localtime && \
    apk add --no-cache tini bash openssh shadow rsyslog && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    usermod -p '!' root; mkdir -p /var/log && \
    touch /var/log/messages && \
    sed -i '/imklog/d' /etc/rsyslog.conf && \
    rm -rf /usr/local/share/doc /usr/local/share/man

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 22

#HEALTHCHECK --interval=10s --timeout=3s --start-period=60s --retries=3 CMD echo PING | nc 127.0.0.1 3310 || exit 1
ENTRYPOINT ["/entrypoint.sh"]
CMD ["tini", "--", "/usr/sbin/sshd", "-D"]
