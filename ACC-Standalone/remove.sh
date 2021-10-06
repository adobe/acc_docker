#!/bin/bash
# Since: November, 2019
# Author: jordy@adobe.com

# Description: 
#    - Stop Docker acc_standalone
#    - Remove docker acc_standalone 

docker stop acc_standalone
docker rm acc_standalone
docker ps -a