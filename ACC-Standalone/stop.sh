#!/bin/bash
# Since: November, 2019
# Author: jordy@adobe.com

# Description: 
#    - Stop docker acc_standalone

docker stop acc_standalone 
docker ps -a 