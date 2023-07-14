FROM ubuntu:latest



RUN apt-get update && apt-get upgrade -y

RUN apt update
RUN apt install apache2 || true

# Install PHP and required extensions
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php || true
RUN apt-get update

RUN apt-get install software-properties-common
RUN add-apt-repository ppa:ondrej/php
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y php8.1

RUN apt-get install php8.1-curl -y 
RUN apt-get install php8.1-cgi -y 
RUN apt-get install php8.1-xsl -y 
RUN apt-get install php8.1-bcmath -y 
RUN apt-get install php8.1-ctype -y
RUN apt-get install php8.1-dom -y 
RUN apt-get install php8.1-gd -y 
RUN apt-get install php8.1-iconv -y 
RUN apt-get install php8.1-intl -y 
RUN apt-get install php8.1-mbstring -y 
RUN apt-get install php openssl -y 
RUN apt-get install php8.1-common php-mysql php-cli 
RUN apt-get install php8.1-pdo-mysql 
RUN apt-get install php8.1-simplexml -y 
RUN apt-get install php8.1-soap -y 
RUN apt-get install php8.1-zip -y 
RUN apt-get install php8.1-libxml -y || true
RUN apt-get install zip -y


RUN apt update || true
RUN apt-get install curl
RUN curl -s https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer


RUN apt-get purge 'php*' -y 
RUN apt-get purge php* 
RUN apt-get autoremove -y
RUN apt-get autoclean -y
RUN apt-get remove dbconfig-php -y || true
RUN apt-get dist-upgrade -y

RUN apt-get install software-properties-common
RUN add-apt-repository ppa:ondrej/php
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y php8.1

RUN apt-get install php8.1-curl -y 
RUN apt-get install php8.1-cgi -y 
RUN apt-get install php8.1-xsl -y 
RUN apt-get install php8.1-bcmath -y 
RUN apt-get install php8.1-ctype -y
RUN apt-get install php8.1-dom -y 
RUN apt-get install php8.1-gd -y 
RUN apt-get install php8.1-iconv -y 
RUN apt-get install php8.1-intl -y 
RUN apt-get install php8.1-mbstring -y 
RUN apt-get install php openssl -y 
RUN apt-get install php8.1-common php-mysql php-cli 
RUN apt-get install php8.1-pdo-mysql 
RUN apt-get install php8.1-simplexml -y 
RUN apt-get install php8.1-soap -y 
RUN apt-get install php8.1-zip -y 
RUN apt-get install php8.1-libxml -y || true
RUN apt-get install zip -y

RUN apt-get update \
    && apt-get install -y php-mysql || true

COPY auth.json /var/www/html
COPY adminer.php /var/www/html/
RUN service apache2 start

Copy magento /var/www/html/magento
Copy .htaccess /var/www/html/magento
Copy index.php /var/www/html/magento

WORKDIR /var/www/html/magento

RUN apt-get install php8.1-xml -y

RUN service apache2 stop
RUN service apache2 start

RUN bin/magento setup:install --db-host=mysqld --base-url="http://127.0.0.1:8080/magento/" --db-name=magento234 --db-user=root --db-password=rootroot --admin-firstname=admin --admin-lastname=admin --admin-email=shaikh.aman@ksolves.com --admin-user=admin --admin-password=Admin@123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1 --backend-frontname=admin --search-engine=elasticsearch7 --elasticsearch-host=elasticsearch --elasticsearch-port=9201