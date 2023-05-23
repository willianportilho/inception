#!bin/sh

if [ -f "/var/www/wp-config.php" ]; then
    {
        echo "<?php"
        echo "define('DB_NAME','${DB_NAME}');"
        echo "define('DB_USER','${DB_USER_NAME}');"
        echo "define('DB_PASSWORD','${DB_USER_PASS}');"
        echo "define('DB_HOST','${DB_HOST_NAME}');"
        echo "define('DB_CHARSET','utf8');"
        echo "define('DB_COLLATE','');"
        echo "define('FS_METHOD','direct');"
        echo "\$table_prefix = 'wp_';"
        echo "define( 'WP_DEBUG', false );"
        echo "if ( ! defined( 'ABSPATH' ) ) {"
        echo "  define( 'ABSPATH', __DIR__ . '/' );"
        echo "}"
        echo "require_once ABSPATH . 'wp-settings.php';"
  } > /var/www/wp-config.php
    }
fi