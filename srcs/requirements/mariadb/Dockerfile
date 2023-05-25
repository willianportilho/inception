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
COPY requirements/mariadb/conf/create_db.sh .
COPY requirements/mariadb/tools/backup.sql .

# executes script
RUN sh create_db.sh

# defines the 'mysql' user to run the commands in the container
USER mysql

# starts the MariaDB server inside the container
CMD ["/usr/bin/mysqld"]