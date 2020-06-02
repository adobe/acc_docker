# Docker Image for Adobe Campaign Classic Standalone
This repository contains Dockerfiles and sample to build your own Docker images for Adobe Campaign Classic.

## Required files
These images will require you to download any required [Adobe Campaign Classic](https://www.adobe.com/marketing/campaign.html) commercial software before installation.
 - nlserver6-v7-[BUILD]-amd64_deb9.deb
 - setup-client-7.0.[BUILD].exe

Download Adobe Campaign Classic from Support Portal:
     https://support.neolane.net/webApp/extranetLogin

Clone or download this repository, include Adobe Campaign (debian9 version) and client console installers on `sources` directory and follow instructions below.
![Screen](/images/sources.png)

## How to
Build your docker image locally: 
```sh
./build.sh 
docker build -t acc_standalone .
```
Use this script to launch the docker container
```sh
./start.sh 
docker run -d -p 80:80 -p 8080:8080 -it --name=acc_standalone acc_standalone:latest
```

Connect to:
```sh
http://localhost:8080 (Client console)
- Login: admin
- Password: neo
```
or
```sh
http://localhost:8080/view/home (Web view)
- Login: admin
- Password: neo
```

To stop the docker container, you can use this script:
```sh
./stop.sh (docker stop acc_standalone)
```
To enter into Docker image as root:
```sh	
./ssh.sh (docker exec -it acc_standalone /bin/bash)
```
If you are using Windows environment, first run the script:
```sh
./setWindowsFormat.bat
```
Environement variables:
| Variable | Default |
| -------- | ------- |
| INSTANCE | acc |
| CAMPAIGN_ADMIN_PASSWORD_VAR | neo |
| CAMPAIGN_INTERNAL_PASSWORD_VAR | neo |
| PG_DB_NAME_VAR | neolane_db |
| PG_USER_VAR | neolane_user |
| PG_PASSWORD_VAR | neolane_pwd |


# Plugins:
## Database Analyzer: 
A powerful tool to explore and understand your datamodel

- URL: [DB Analyzer](http://localhost:8080/nl/dbanalyser/index.html?baseurl=http%3A%2F%2Flocalhost:8080&columnsdepth=10&preset=custom&loglevel=0&maxtoload=10&analyzedepth=30&nocache=false#) (once docker started)

**Enjoy, and feel free to improve it!**
