FROM alpine:3.19

RUN adduser -u 1000 -G www-data -s /bin/sh -D www-data

RUN apk update && apk add --no-cache nodejs npm

COPY website /website

RUN mkdir -p /var/www/html \
&& chown -R www-data:www-data /var/www/html \
&& chown -R www-data:www-data /website

COPY docker-entrypoint.sh /docker-entrypoint.sh

USER www-data

WORKDIR /website

VOLUME /var/www/html

ENTRYPOINT [ "/docker-entrypoint.sh" ]