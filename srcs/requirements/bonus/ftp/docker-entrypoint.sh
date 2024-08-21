#!/bin/sh

set -e

grep '/ftp/' /etc/passwd | cut -d':' -f1 | xargs -r -n1 deluser

addgroup -g 1000 $FTP_USER

echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" | adduser -h /ftp/data -s /sbin/nologin -u 1000 -G $FTP_USER $FTP_USER
mkdir -p /ftp/data
chown $FTP_USER:$FTP_USER /ftp/data

exec "$@"