# acc_docker
Adobe Campaign Classic Docker Standalone

## Prerequisites
Adobe Campaign Classic is not included. 

Docker Desktop is required.

Client console should be installed on your computer. 

To run this docker, include your Adobe Campaign sources on "sources" directory (debian9 *.deb only) and follow instructions below. 

## How to get (build locally)?
Clone `jordykovic/acc_docker` from here and build it yourself from the Dockerfile with the
following command executed:


	./build.sh (docker build -t acc_standalone .)

Use this command to launch the docker container

	./start.sh (docker run -d -p 80:80 -p 8080:8080 -it --name=acc_standalone acc_standalone:latest)

Connect to:

	http://localhost:8080 (Client console)
	Login: admin - neo
	or
	http://localhost:8080/view/home (Web)
	Login: admin - neo
	
To stop the docker container

	./stop.sh (docker stop acc_standalone)

To enter into Docker image as root:
	
	./ssh.sh (docker exec -it acc_standalone /bin/bash)

If you are using Windows environment, first run the script:

        ./setWindowsFormat.bat

Environement variables:
	
	PostgreSQL Database Name: PG_DB_NAME_VAR =  neolane_db
	PostgreSQL User Name: PG_USER_VAR = neolane_user 
	PostgreSQL User Password: PG_PASSWORD_VAR =  neolane_pwd 
	
	Campaign Admin Name: CAMPAIGN_ADMIN_USER_VAR =  neo
	Campaign Admin Password: CAMPAIGN_ADMIN_PASSWORD_VAR = neo 
	Campaign Internal Password: CAMPAIGN_INTERNAL_PASSWORD_VAR = neo

Plugins:
Database Analyzer: A powerful tool to explore and understand your datamodel
	- URL: http://localhost:8080/nl/dbanalyser/index.html?baseurl=http%3A%2F%2Flocalhost:8080&columnsdepth=10&preset=custom&loglevel=0&maxtoload=10&analyzedepth=30&nocache=false#

Enjoy, and feel free to improve it! 
