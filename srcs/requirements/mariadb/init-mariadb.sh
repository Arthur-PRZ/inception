#!/bin/bash
#service mysql start;

mkdir -p /var/run/mysqld
chown mysql:mysql /var/run/mysqld

mysql_install_db --user=mysql --datadir=/var/lib/mysql

mysqld --user=mysql &
sleep 5

mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
#mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
sleep 2

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

exec mysqld --user=mysql
