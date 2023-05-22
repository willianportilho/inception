#!bin/sh

if [ ! -d "/var/run/mysqld" ]; then
	mkdir /var/run/mysqld
    chmod 777 /var/run/mysqld
	chown -R mysql:mysql /var/run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # inicializa os diretórios e arquivos necessários para o DB
    mysql_install_db --datadir=/var/lib/mysql --user=mysql
    chown -R mysql:mysql /var/lib/mysql
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
	{
		echo "USE mysql;"
		echo "FLUSH PRIVILEGES;"
		echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
		echo "CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;"
		echo "CREATE USER '${DB_USER_NAME}'@'%' IDENTIFIED by '${DB_USER_PASS}';"
		echo "GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER_NAME}'@'%';"
		echo "FLUSH PRIVILEGES;"
	} | /usr/bin/mysqld --user=mysql --bootstrap
fi