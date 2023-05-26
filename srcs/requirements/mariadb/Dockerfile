FROM alpine:3.17

# define arguments
ARG DB_NAME \
    DB_USER_NAME \
    DB_USER_PASS \
    DB_ROOT_PASS

# install required dependencies
RUN apk update && apk add --no-cache mariadb mariadb-client

# exposes 3306 default mariadb port
EXPOSE 3306

# copies script and backup files into container
COPY requirements/mariadb/tools/create_db.sh .
COPY requirements/mariadb/conf/backup.sql .

# change the permissions and run the script
RUN chmod +x create_db.sh && sh create_db.sh

# defines the 'mysql' user to run the commands in the container
USER mysql

# starts the MariaDB server inside the container
CMD ["/usr/bin/mysqld"]