#!bin/sh

# allow mariadb to accept network connections (wordpress can connect like this)
sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

{
	# section
	echo '[mysqld]';

	# set like this allows MariaDB to accept any available network connection
	echo 'bind-address=0.0.0.0';
}	>> /etc/my.cnf.d/docker.cnf

# used for storing sockets (clients can connect to the socket and send requests to the server)
# and PID (init, stop and restart maneger)
if [ ! -d "/var/run/mysqld" ]; then
	mkdir /var/run/mysqld
    chmod 777 /var/run/mysqld
	chown -R mysql:mysql /var/run/mysqld
fi

# stores data files related to "mysql" database
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # initialize the necessary directories and files for the DB
    mysql_install_db --datadir=/var/lib/mysql --user=mysql
    chown -R mysql:mysql /var/lib/mysql
fi

# check if the data directory of database 'wordpress' exists
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
	{
		# tells mariadb that the next commands will be done in the mysql context
		echo "USE mysql;"

		# updates the changes made
		echo "FLUSH PRIVILEGES;"

		# change the root password
		echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"

		# creates a new database with character type instructions
		echo "CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;"

		# creates a new user
		echo "CREATE USER '${DB_USER_NAME}'@'%' IDENTIFIED by '${DB_USER_PASS}';"

		# grant all wordpress database permissions to user
		echo "GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER_NAME}'@'%';"

		# updates the changes made
		echo "FLUSH PRIVILEGES;"
	} | /usr/bin/mysqld --user=mysql --bootstrap

	# waits until the mysqladmin command can connect to the MySQL server and receive a valid response.
	/usr/bin/mysqld --user=mysql &
	while ! mysqladmin -uroot -p"${DB_ROOT_PASS}" ping -h localhost --silent; do
		sleep 1
	done

	# import database backup
    mysql -uroot -p"${DB_ROOT_PASS}" ${DB_NAME} < ./backup.sql
fi