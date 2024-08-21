FROM alpine:3.19

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen

COPY docker-entrypoint.sh / 

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["mysqld", "--user=mysql", "--console", "--skip-name-resolve", "--skip-networking=0"]