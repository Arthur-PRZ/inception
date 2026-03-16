#!/bin/bash

sleep 10

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Creation du fichier wp-config.php avec wp.cli..."

	wp config create \
		--path=/var/www/html \
		--dbname="${WORDPRESS_DB_NAME}" \
		--dbuser="${WORDPRESS_DB_USER}" \
		--dbpass="${WORDPRESS_DB_PASSWORD}" \
		--dbhost="${WORDPRESS_DB_HOST}" \
		--allow-root
	echo "configuration terminée !"
else
	echo "wp-config.php existe déjà, configuration ignorée"
fi 

php-fpm8.2 -F
