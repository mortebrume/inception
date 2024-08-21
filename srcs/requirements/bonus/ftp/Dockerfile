FROM alpine:3.19

RUN apk update && apk add --no-cache vsftpd

#RUN touch /var/log/vsftpd.log \
#&& ln -sf /dev/stdout /var/log/vsftpd.log

COPY vsftpd.conf /etc/vsftpd.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 20/tcp 21/tcp 21000-21010

CMD ["vsftpd", "-opasv_min_port=21000", "-opasv_max_port=21010", "/etc/vsftpd.conf"]