# ADOBE CAMPAIGN CLASSIC DOCKER PROJECT
# --------------------------
# This is the dockerfile for Adobe Campaign Classic (standalone version)
# 
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) nlserver6-v7-[BUILD]-amd64_deb9.deb
# (2) setup-client-7.0.[BUILD].exe
#
#     Download Adobe Campaign Classic from Support Portal 
#     https://support.neolane.net/webApp/extranetLogin
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Copy Campaign application and client console files in the /sources directory
# Run script build.sh to build docker acc_standalone
# Run script start.sh to start docker acc_standalone
#
# Pull base image
# ---------------
FROM debian:stretch

# Maintainer
# ----------
MAINTAINER jordy@adobe.com


# Build to install 
# ---------------------------------------------
ENV BUILD *.deb

# Environment variables required for PostgreSQL 
# ---------------------------------------------
ENV PG_DB_NAME_VAR neolane_db
ENV PG_USER_VAR neolane_user 
ENV PG_PASSWORD_VAR neolane_pwd

# Environment variables required for Campaign 
# -------------------------------------------
ENV INSTANCE acc1
ENV CAMPAIGN_ADMIN_PASSWORD_VAR neo 
ENV CAMPAIGN_INTERNAL_PASSWORD_VAR neo 

# Debian 9 prerequisites 
# ----------------------
RUN apt-get update \
 	&& apt-get upgrade -y  \
	&& apt-get install -y apt-utils systemd-container unixodbc mlocate curl vim wget apache2 telnet elinks openssh-server bc libicu57 libprotobuf10 libcurl3 libc-ares2 openjdk-8-jdk phantomjs postgresql-client postgresql locales\
	&& apt-get clean all \
	&& rm -rf /var/lib/apt/lists/* 

#Locales
# ----------------------
RUN sed -i 's/# en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen && sed -i 's/# en_US.ISO-8859-15 ISO-8859-15/en_US.ISO-8859-15 ISO-8859-15/' /etc/locale.gen && sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen


# Campaign installer and configuration scripts
# --------------------------------------------
COPY acc_install.sh apache.sh monitor.sh acc_start.sh setup_instance.js /
COPY sources /sources
RUN chmod a+x /*.sh &&\
	chmod a+x /*.js

# PostgreSQL configuration
# ------------------------
RUN sed -i -e "s/^[# ]*\\(listen_addresses[ ]*=[ ]*'\\)[^']*\\('.*\\)$/\\1*\\2/" /etc/postgresql/9.6/main/postgresql.conf &&\
	sed -i 's/peer/trust/g' /etc/postgresql/9.6/main/pg_hba.conf

RUN service postgresql start &&\
	su postgres -c "createuser -d -r -s root" &&\
	createuser $PG_USER_VAR &&\
	createdb $PG_DB_NAME_VAR -O $PG_USER_VAR &&\
	psql $PG_DB_NAME_VAR -c "alter user $PG_USER_VAR with encrypted password '$PG_PASSWORD_VAR';" &&\
	psql $PG_DB_NAME_VAR -c "create extension pgcrypto;" &&\
    service postgresql stop

# Campaign installation & configuration
# -------------------------------------
RUN dpkg -i /sources/$BUILD 
RUN /acc_install.sh 

RUN service postgresql start &&\
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/neolane/nl6/lib &&\
	export PATH=$PATH:/usr/local/neolane/nl6/bin &&\
	export LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/:$LD_LIBRARY_PATH &&\
	su neolane -c "/usr/local/neolane/nl6/bin/nlserver javascript -instance:$INSTANCE -file setup_instance.js" &&\
    service postgresql stop

# Apache configuration (port 80)
# --------------------
RUN /apache.sh 

# Snowflake FDA
# -----------------------------------------------------
RUN /usr/local/neolane/nl6/bin/fda-setup-scripts/snowflake_odbc-setup.sh

# Google Big Query FDA 
# -----------------------------------------------------
RUN /usr/local/neolane/nl6/bin/fda-setup-scripts/bigquery_odbc-setup.sh
#RUN /usr/local/neolane/nl6/bin/fda-setup-scripts/bigquery_sdk-setup.sh

# DB Analyser plugin (optional)
# -----------------------------
COPY /sources/dbanalyser/ /usr/local/neolane/nl6/web/dbanalyser
COPY /sources/dbajssp /usr/local/neolane/nl6/datakit/xtk/eng/jssp/

# Client console availability
# ---------------------------
COPY /sources/setup-*.exe /usr/local/neolane/nl6/datakit/nl/eng/jsp/

# Default neolane user rights
# ---------------------------
RUN cd /usr/local/ &&\
	chown -R neolane:neolane neolane &&\
	chmod -R 775 neolane &&\
	chmod 755 neolane

# Docker internal network ports
# -----------------------------
EXPOSE 80
EXPOSE 8080
EXPOSE 22 

# Default script to start Campaign + Apache + PostgreSQL
# ------------------------------------------------------
ENTRYPOINT /acc_start.sh
