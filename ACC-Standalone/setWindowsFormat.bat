@echo off
:: Script to rename files for usage on Windows platform


set itype=n
set /p itype=Do you want to change files to Windows format [n/y] (default - %itype%)?:

IF %itype%==N set itype=n
IF %itype%==Y set itype=y

IF %itype%==n (
    ::Do nothing
	ECHO Files not changed, exiting.
	)


IF %itype%==y (
    ::Change file extensions to .bat 
	ECHO Renaming files to .bat extension
    ren .\build.sh build.bat
    ren .\remove.sh remove.bat
    ren .\ssh.sh ssh.bat
    ren .\start.sh start.bat
    ren .\stop.sh stop.bat
    )