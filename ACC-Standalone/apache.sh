#!/bin/bash
# Since: November, 2019
# Author: jordy@adobe.com

# Description: 
#    - Configure Apache / Campaign integration 

a2dismod -f auth_basic authn_file authz_user autoindex cgi dir env negotiation userdir &&\
a2enmod  alias authz_host mime &&\
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
usermod neolane -G www-data &&\
usermod www-data -G neolane 
