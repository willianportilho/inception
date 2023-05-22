FROM alpine:3.17.3

ARG DB_NAME \
    DB_USER_NAME \
    DB_USER_PASS \
    DB_ROOT_PASS

RUN apk update && apk add --no-cache mariadb mariadb-client

# bind-address (define o endereço IP ao qual o servidor aceitará conexões de rede.)
# definido assim, permite que o MariaDB aceite qualquer conexão de rede disponível
# O wordpress por exemplo, pode se conectar a ele com seu nome host (mariadb) ou seu ip.
# skip-networking=0 permite que maridb aceite conexões de rede (wordpress consegue se conectar assim)
RUN { echo '[mysqld]'; \
      echo 'bind-address=0.0.0.0'; \
    } >> /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh
USER mysql
CMD ["/usr/bin/mysqld"]