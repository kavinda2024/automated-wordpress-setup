#!/bin/bash

# Update system packages
sudo apt update

# Install Apache, MySQL, PHP 
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip -y

# Create wordpress directory and set permissions
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www

# Download and extract WordPress
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

# Configure Apache virtual host
cat > /etc/apache2/sites-available/wordpress.conf <<EOF
<VirtualHost *:80>
         DocumentRoot /srv/www/wordpress
         <Directory /srv/www/wordpress>
             Options FollowSymLinks
             AllowOverride Limit Options FileInfo
             DirectoryIndex index.php
             Require all granted
         </Directory>
         <Directory /srv/www/wordpress/wp-content>
             Options FollowSymLinks
             Require all granted
         </Directory>
</VirtualHost>
EOF

# Enable the WordPress site and required modules
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default

# Setup MySQL database and user for WordPress
mysql -u root -e "CREATE DATABASE wordpress;"
mysql -u root -e "CREATE USER wordpress@localhost IDENTIFIED BY 'admin123';"
mysql -u root -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost;"
mysql -u root -e "FLUSH PRIVILEGES;"

# Configure wp-config.php
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/admin123/' /srv/www/wordpress/wp-config.php

# Restart services
sudo systemctl reload mysql
sudo systemctl reload apache2

