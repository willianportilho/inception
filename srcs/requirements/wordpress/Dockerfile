FROM alpine:3.17

ARG DB_NAME \
    DB_USER_NAME \
    DB_USER_PASS \
	DB_HOST_NAME

RUN apk add --no-cache  	\
		php8.1-common     	\
		php8.1-session    	\
		php8.1-iconv      	\
		php8.1-json       	\
		php8.1-gd         	\
		php8.1-curl       	\
		php8.1-xml        	\
		php8.1-mysqli     	\
		php8.1-imap       	\
		php8.1-pdo        	\
		php8.1-pdo_mysql  	\
		php8.1-soap       	\
		php8.1-xmlrpc     	\
		php8.1-posix      	\
		php8.1-mcrypt     	\
		php8.1-gettext    	\
		php8.1-ldap       	\
		php8.1-ctype		\
		php8.1-dom			\
		php8.1-simplexml	\
		wget				\
		tar

RUN		{ sed -i "s/listen = 127.0.0.1:9000/listen = 9000/g" \
		&& sed -i "s/;listen.owner = nobody/listen.owner = nobody/g" \
		&& sed -i "s/;listen.group = nobody/listen.group = nobody/g"; } \
		/etc/php8.1/php-fpm.d/www.conf


WORKDIR	/var/www

RUN		wget http://wordpress.org/latest.tar.gz; \
		tar -xzvf latest.tar.gz; \
		rm latest.tar.gz

COPY	./requirements/wordpress/conf/wp-config-create.sh

RUN		wp-conf-create.sh

CMD ["/usr/sbin/php-fpm8.1", "-F"]