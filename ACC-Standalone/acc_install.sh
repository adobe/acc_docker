#!/bin/bash
# Since: November, 2019
# Author: jordy@adobe.com

# Description: 
#    - install Campaign Build
#    - Configure ServerConf.xml file with default parameters
#    - Create standalone Campaign instance
#    - Configure Campaign instance 

# Path settings
# ---------------------
sed -i '$a\\' /root/.bashrc
sed -i '$a\#Adobe Campaign Configuration' /root/.bashrc
sed -i '$a\export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/neolane/nl6/lib' /root/.bashrc
sed -i '$a\export PATH=$PATH:/usr/local/neolane/nl6/bin' /root/.bashrc
sed -i '$a\export LD_LIBRARY_PATH=/usr/lib/jvm/java-8-oracle/lib/amd64:/usr/lib/jvm/java-8-oracle/jre/lib/amd64/' /root/.bashrc

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/neolane/nl6/lib
export PATH=$PATH:/usr/local/neolane/nl6/bin
export LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/:$LD_LIBRARY_PATH

# Start PostgreSQL
# ---------------------
/etc/init.d/postgresql start

# Create instance $INSTANCE
# ----------------------------
nlserver config -internalpassword:/$CAMPAIGN_INTERNAL_PASSWORD_VAR
nlserver config -addinstance:$INSTANCE/*/eng

nlserver config -instance:$INSTANCE -createdb -cnx:[postgresql:$PG_USER_VAR:$PG_DB_NAME_VAR/$PG_PASSWORD_VAR@localhost:5432,timezone=America/New_York,unicodeData=true,usetimestamptz=true,NChar=true,unicodeData=1] \
		 -internalpwd:$CAMPAIGN_INTERNAL_PASSWORD_VAR \
		 -packages:[nms:core,nms:campaign,nms:amp,nms:mrm,nms:interaction,nms:social,nms:messageCenterControl,nms:paper,nms:mobile,nms:phone,nms:mobileApp,ncm:content,nms:survey,nms:neolap,nms:response,nms:federatedDataAccess,nms:campaignOptimization,nms:purl,nms:coupon,nms:centralLocal,crm:connectors,nms:webAnalytics,nms:aemIntegration,nms:aamIntegration]

# Configure ServerConf.xml
# ------------------------
sed -i 's/maxSpareServers="2"/maxSpareServers="4"/g' /usr/local/neolane/nl6/conf/serverConf.xml
sed -i 's/maxWorkingSetMb="128"/maxWorkingSetMb="512"/g' /usr/local/neolane/nl6/conf/serverConf.xml
sed -i 's|spamCheck command=""|spamCheck command="perl /usr/local/neolane/nl6/bin/spamcheck.pl"|g' /usr/local/neolane/nl6/conf/serverConf.xml
sed -i 's|allowEmptyPassword="false"|allowEmptyPassword="true"|g' /usr/local/neolane/nl6/conf/serverConf.xml
sed -i 's/<dnsConfig localDomain="''"/<dnsConfig localDomain="'adobe.com'"'/g /usr/local/neolane/nl6/conf/serverConf.xml
sed -i 's/xMailer="nlserver, Build $(PRODUCT_VERSION)"/xMailer="Adobe Campaign Infinity"/g' /usr/local/neolane/nl6/conf/serverConf.xml

# Configure config-default.xml
# ----------------------------
sed -i 's/trackinglogd autoStart="'false'"/trackinglogd autoStart="'true'"'/g /usr/local/neolane/nl6/conf/config-default.xml

# Configure instance (config-$INSTANCE.xml)
# -----------------------------------------
sed -i 's/mta autoStart="'true'"/mta autoStart="'true'"'/g /usr/local/neolane/nl6/conf/config-$INSTANCE.xml
sed -i 's/statServerAddress="''"/statServerAddress="'localhost:7777'"'/g /usr/local/neolane/nl6/conf/config-$INSTANCE.xml
sed -i 's/stat autoStart="'true'"/stat autoStart="'true'"'/g /usr/local/neolane/nl6/conf/config-$INSTANCE.xml
sed -i 's/wfserver autoStart="'true'"/wfserver autoStart="'true'"'/g /usr/local/neolane/nl6/conf/config-$INSTANCE.xml
sed -i 's/sms autoStart="'false'"/sms autoStart="'true'"'/g /usr/local/neolane/nl6/conf/config-$INSTANCE.xml
sed -i 's/inMail autoStart="'true'"/inMail autoStart="'true'"'/g /usr/local/neolane/nl6/conf/config-$INSTANCE.xml
sed -i 's/interactiond autoStart="'false'"/interactiond autoStart="'true'"'/g /usr/local/neolane/nl6/conf/config-$INSTANCE.xml
sed -i 's/IP address="''" heloHost="" publicId="''" weight="''"/IP address="'0.0.0.0'" heloHost="" publicId="'1'" weight="'1'"'/g /usr/local/neolane/nl6/conf/config-$INSTANCE.xml

# Fix default neolane user rights
# ----------------------------
cd /usr/local/
chown -R neolane:neolane neolane
chmod -R 775 neolane
chmod 755 neolane

# Stop PostgreSQL
# ----------------------------
/etc/init.d/postgresql stop


