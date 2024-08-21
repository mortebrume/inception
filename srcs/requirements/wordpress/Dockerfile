FROM alpine:3.19

RUN apk update && apk add --no-cache ca-certificates curl openssl tar xz \
php83 php83-phar php83-fpm php83-curl php83-dom php83-fileinfo \ 
php83-intl php83-opcache php83-zip php83-pecl-redis php83-openssl php83-iconv php83-tokenizer \
php83-xml php83-xmlreader php83-simplexml php83-xmlwriter php83-mysqli php83-ctype mariadb-client

RUN ln -s /usr/bin/php83 /usr/bin/php \
	&& adduser -u 82 -D -S -G www-data www-data

RUN [ ! -d /var/www/html ]; \
	mkdir -p /var/www/html; \
	chown www-data:www-data /var/www/html; \
	chmod 1777 /var/www/html;

RUN mkdir -p /var/www/html/wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/bin/wp

COPY docker-entrypoint.sh /

WORKDIR /var/www/html/wordpress

RUN cd /etc/php83; \
    { \
        echo '[global]'; \
        echo 'error_log = /proc/self/fd/2'; \
        echo; \
        echo '[www]'; \
        echo 'access.log = /proc/self/fd/2'; \
        echo; \
        echo 'clear_env = no'; \
        echo; \
        echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
        echo 'catch_workers_output = yes'; \
        echo 'decorate_workers_output = no'; \
    } | tee php-fpm.d/docker.conf; \
    { \
        echo '[global]'; \
        echo 'daemonize = no'; \
        echo; \
        echo '[www]'; \
        echo 'listen = 9000'; \
    } | tee php-fpm.d/zz-docker.conf; \
    { \
        echo 'fastcgi.logging = Off'; \
    } > "/etc/php83/conf.d/docker-fpm.ini"

STOPSIGNAL SIGQUIT

EXPOSE 9000

VOLUME /var/www/html

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm83", "-F"]