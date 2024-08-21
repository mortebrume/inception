FROM alpine:3.19

RUN apk update && apk add --no-cache ca-certificates curl openssl tar xz \
php83 php83-phar php83-fpm php83-curl php83-dom php83-fileinfo \ 
php83-intl php83-opcache php83-zip php83-pecl-redis php83-openssl php83-iconv php83-tokenizer \
php83-xml php83-xmlreader php83-simplexml php83-xmlwriter php83-mysqli php83-ctype mariadb-client

RUN	echo "upload_max_filesize = 128M" >> /etc/php83/conf.d/0-upload_large_dumps.ini \
&&	echo "post_max_size = 128M" >> /etc/php83/conf.d/0-upload_large_dumps.ini \
&&	echo "memory_limit = 1G" >> /etc/php83/conf.d/0-upload_large_dumps.ini \
&&	echo "max_execution_time = 600" >> /etc/php83/conf.d/0-upload_large_dumps.ini \
&&	echo "max_input_vars = 5000" >> /etc/php83/conf.d/0-upload_large_dumps.ini

RUN ln -s /usr/bin/php83 /usr/bin/php \
	&& adduser -u 82 -D -S -G www-data www-data

RUN  [ ! -d /var/www/html ]; \
	mkdir -p /var/www/html; \
	chown www-data:www-data /var/www/html; \
	chmod 1777 /var/www/html;

RUN mkdir -p /var/www/html/adminer

RUN set -e ; curl -fsSL "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -o /var/www/html/adminer/index.php

COPY docker-entrypoint.sh /

WORKDIR /var/www/html/adminer

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