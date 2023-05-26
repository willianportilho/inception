FROM alpine:3.17

# define arguments
ARG DB_NAME \
    DB_USER_NAME \
    DB_USER_PASS \
	DB_HOST_NAME

# install required dependencies
RUN apk add --no-cache  \
	php81				\
	php81-fpm			\
	php81-common		\
	php81-session		\
	php81-iconv			\
	php81-json			\
	php81-gd			\
	php81-curl			\
	php81-xml			\
	php81-mysqli		\
	php81-imap			\
	php81-pdo			\
	php81-pdo_mysql		\
	php81-soap			\
	php81-posix			\
	php81-gettext		\
	php81-ldap			\
	php81-ctype			\
	php81-dom			\
	php81-simplexml		\
	mariadb-client		\
	wget				\
	tar

# defines the directory to run the next commands in the container
WORKDIR	/var/www

# copies script file into container
COPY ./requirements/wordpress/conf/wp-config-create.sh .

# change the permissions and run the script
RUN	chmod +x wp-config-create.sh && sh wp-config-create.sh

# runs PHP-FPM server in foreground inside container
CMD ["/usr/sbin/php-fpm81", "-F"]