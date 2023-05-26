#!bin/sh

# allows communication between nginx and php-fpm
sed -i "s/listen = 127.0.0.1:9000/listen = 9000/g" /etc/php81/php-fpm.d/www.conf

# allows PHP-FPM and Nginx to interact properly and share the correct permissions
sed -i "s/;listen.owner = nobody/listen.owner = nobody/g" /etc/php81/php-fpm.d/www.conf
sed -i "s/;listen.group = nobody/listen.group = nobody/g" /etc/php81/php-fpm.d/www.conf

# download wordpress
wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
cp -rf wordpress/* .
rm -rf wordpress latest.tar.gz


if [ ! -f "/var/www/wp-config.php" ]; then
    {
        echo "<?php"

        # database name to be used by WordPress
        echo "define('DB_NAME','${DB_NAME}');"

        # database username to be used by WordPress
        echo "define('DB_USER','${DB_USER_NAME}');"

        # database user password to be used by WordPress
        echo "define('DB_PASSWORD','${DB_USER_PASS}');"

        # host (server) of the database to be used by WordPress
        echo "define('DB_HOST','${DB_HOST_NAME}');"

        # character set to be used by the database
        echo "define('DB_CHARSET','utf8');"
        
        # WordPress uses the default database collation.
        echo "define('DB_COLLATE','');"

        # allows WordPress to access files directly on the file system
        echo "define('FS_METHOD','direct');"

        # prefix of WordPress database tables
        echo "\$table_prefix = 'wp_';"

        # sets the WP_DEBUG constant to false, disabling WordPress debug mode
        echo "define( 'WP_DEBUG', false );"

        # sets the ABSPATH constant to the value of the current directory (__DIR__)
        echo "if ( ! defined( 'ABSPATH' ) ) {"
        echo "  define( 'ABSPATH', __DIR__ . '/' );"
        echo "}"

        # requires wp-settings.php file, responsible for loading the main WordPress settings and starting the system execution
        echo "require_once ABSPATH . 'wp-settings.php';"
    }   > /var/www/wp-config.php
fi