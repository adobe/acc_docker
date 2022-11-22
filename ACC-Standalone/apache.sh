#!/bin/bash
# Since: November, 2019
# Author: jordy@adobe.com

# Description: 
#    - Configure Apache / Campaign integration 

#Auto-Signed certificate (to use HTTPS)
mkdir /etc/apache2/certificate && \
cd /etc/apache2/certificate && \
openssl genrsa -des3 -passout pass:password -out server.pass.key 2048 && \
openssl rsa -passin pass:password -in server.pass.key -out server.key && \
rm server.pass.key && \
openssl req -new -key server.key -out server.csr -subj "/C=EU/ST=FR/L=Paris/O=Campaign/OU=Classic/CN=$INSTANCE" && \
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

#Apache configuration
a2dismod -f auth_basic authn_file authz_user autoindex cgi dir env negotiation userdir &&\
a2enmod  alias authz_host mime ssl rewrite &&\
touch /etc/apache2/mods-available/nlsrv.load &&\
echo "LoadModule requesthandler24_module /usr/local/neolane/nl6/lib/libnlsrvmod.so" >> /etc/apache2/mods-available/nlsrv.load &&\
ln -s /usr/local/neolane/nl6/tomcat-7/conf/apache_neolane.conf /etc/apache2/mods-available/nlsrv.conf &&\
a2enmod nlsrv &&\
sed -i '$a\\' /etc/apache2/envvars &&\
sed -i '$a\#Adobe Campaign Configuration' /etc/apache2/envvars &&\
sed -i '$a\export LD_LIBRARY_PATH=/usr/local/neolane/nl6/lib:\$LD_LIBRARY_PATH' /etc/apache2/envvars &&\
sed -i '$a\export USERPATH=/usr/local/neolane' /etc/apache2/envvars &&\
sed -i '/Order allow\,deny/d;s/Allow from all/Require all granted/g' /usr/local/neolane/nl6/tomcat-7/conf/apache_neolane.conf &&\
sed -i '/Order deny,allow/d;s/Deny from all/Require all denied/g' /usr/local/neolane/nl6/tomcat-7/conf/apache_neolane.conf &&\
echo "<Directory /var/www/html>
  AllowOverride All
</Directory>" >> /usr/local/neolane/nl6/tomcat-7/conf/apache_neolane.conf &&\
echo "<VirtualHost *:443>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
        SSLEngine on
        SSLCertificateFile /etc/apache2/certificate/server.crt
        SSLCertificateKeyFile /etc/apache2/certificate/server.key
</VirtualHost>" >> /etc/apache2/sites-available/000-default.conf &&\
usermod neolane -G www-data &&\
usermod www-data -G neolane 
