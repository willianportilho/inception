FROM alpine:3.17

ARG DB_NAME \
    DB_USER_NAME \
    DB_USER_PASS \
    DB_ROOT_PASS

RUN apk update && apk add --no-cache mariadb mariadb-client

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .
COPY requirements/mariadb/tools/backup.sql .
RUN sh create_db.sh
USER mysql
CMD ["/usr/bin/mysqld"]