# Docker Image for Adobe Campaign Classic Standalone
This repository contains Dockerfiles and sample to build your own Docker images for Adobe Campaign Classic.


## Prerequisites
Before using this docker, here is couple of things you need to check: 
- A first view on Docker is better
    - Minimum to know: https://docs.docker.com/get-started/
    - More concepts: https://docker-curriculum.com/ 
- Docker CE is installed and ready on your laptop:
    -  Windows: https://docs.docker.com/docker-for-windows/install/
    - Mac: https://docs.docker.com/docker-for-mac/install/
- Port 80 and 8080 are not already used
    - Windows helper: https://rb.gy/srhpvs
    - Mac tool: https://rb.gy/p9ee9n
- And finally, you need Campaign Classic basics ! 
    - https://docs.adobe.com/content/help/en/campaign-classic-learn/tutorials/getting-started/introduction-to-adobe-campaign-classic.html

## Required files
These images will need you to download any required [Adobe Campaign Classic](https://www.adobe.com/marketing/campaign.html) commercial software before installation.
 - nlserver6-v7-[BUILD]-amd64_deb9.deb
 - setup-client-7.0.[BUILD].exe

Download Adobe Campaign Classic from [Adobe Software Portal](https://experience.adobe.com/#/downloads/content/software-distribution/en/campaign.html)

Clone or download this repository, include Adobe Campaign (debian9 version) and client console installers on `sources` directory

![sources](https://github.com/adobe/acc_docker/blob/master/images/sources.png)

Then follow instructions below:

## How to get?
Clone `adobe/acc_docker` from GitHub, go to 'ACC-Standalone/' and build it:

```sh
./build.sh 
docker build -t acc_standalone .
```
## How to start?
Use this command to launch containers
```sh
./start.sh 
docker run -d -p 80:80 -p 8080:8080 -it --name=acc_standalone acc_standalone:latest
```

## How to test?
Check if instance is running (from your favorite navigator):

	http://localhost:8080/view/supervision
	Login: admin  
	Password: Your password (default is neo)
	
## How to connect from client console?
>If you're using Mac or Linux as Docker server and a VM for Windows Client console, you need to replace [localhost] by your Docker server IP 

Connect to instance:

	http://localhost:8080
	Login: admin
	Password: Your password (default is neo)

## How to stop and remove Docker? 
To stop the docker container, you can use this script:
```sh
./stop.sh (docker stop acc_standalone)
```
## How to connect to ssh?
To enter into Docker image as root:
```sh	
./ssh.sh (docker exec -it acc_standalone /bin/bash)
```
## How to monitor PostgreSQL?
Enter into Docker image as root:
```sh	
./ssh.sh (docker exec -it acc_standalone /bin/bash)
watch -n1 bash monitor.sh
```
## How to run Docker on Windows?
If you are using Windows environment, first run the script:
```sh
./setWindowsFormat.bat
```
## Environment variables:

| Variable | Default |
| -------- | ------- |
| BUILD | *.deb |
| INSTANCE | acc1 |
| CAMPAIGN_ADMIN_PASSWORD_VAR | neo |
| CAMPAIGN_INTERNAL_PASSWORD_VAR | neo |
| PG_DB_NAME_VAR | neolane_db |
| PG_USER_VAR | neolane_user |
| PG_PASSWORD_VAR | neolane_pwd |


## Additional tool - Data model Analyzer:
- URL: http://localhost:8080/nl/dbanalyser/index.html?baseurl=http%3A%2F%2Flocalhost:8080&columnsdepth=10&preset=custom&loglevel=0&maxtoload=10&analyzedepth=30&nocache=false#
    - Login: admin
    - Password: Your password (default is neo)

**Enjoy, and feel free to improve it!**
