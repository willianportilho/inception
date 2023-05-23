FROM alpine:3.17

ARG DB_NAME \
    DB_USER_NAME \
    DB_USER_PASS \
	DB_HOST_NAME

RUN apk add --no-cache  \
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
	# php81-xmlrpc		\
	php81-posix			\
	# php81-mcrypt		\
	php81-gettext		\
	php81-ldap			\
	php81-ctype			\
	php81-dom			\
	php81-simplexml		\
	wget				\
	tar

RUN		sed -i "s/listen = 127.0.0.1:9000/listen = 9000/g" /etc/php81/php-fpm.d/www.conf && \
		sed -i "s/;listen.owner = nobody/listen.owner = nobody/g" /etc/php81/php-fpm.d/www.conf && \
		sed -i "s/;listen.group = nobody/listen.group = nobody/g" /etc/php81/php-fpm.d/www.conf


WORKDIR	/var/www

RUN		wget http://wordpress.org/latest.tar.gz; \
		tar -xzvf latest.tar.gz; \
		rm latest.tar.gz

COPY	./requirements/wordpress/conf/wp-config-create.sh .

RUN		chmod +x wp-config-create.sh && sh wp-config-create.sh

CMD ["/usr/sbin/php-fpm81", "-F"]