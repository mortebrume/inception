#!/bin/sh

set -e

if [ ! -e index.php ] && [ ! -e wp-includes/version.php ]; then
	if [ "$uid" = '0' ] && [ "$(stat -c '%u:%g' .)" = '0:0' ]; then
		chown www-data:www-data .
	fi
	wp core download
	wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb
	wp core install --url=https://${DOMAIN_NAME}/wordpress --title=Inception --admin_user=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email
	wp user create ${WP_USER} ${WP_EMAIL} --user_pass=${WP_PASSWORD} --role=author
	wp plugin install redis-cache --activate
	wp config set WP_REDIS_HOST redis
	wp config set WP_REDIS_PREFIX aattali.42.fr
	wp redis enable
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm83 "$@"
fi

exec "$@"