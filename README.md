# docker-domainmod
Domainmod under Docker

Forked from koshatul/docker-domainmod

### DOMAINMOD DOCKER CONTAINER ###

Had to add some lines to the Dockerfile and Modify docker-compose to fit my needs.

Installation (going off of memory - not going to rebuild this again)

### Create container-data folder & clone Git repos to it
sudo mkdir -p /container-data/domainmod 
cd /container-data/domainmod
sudo git clone https://github.com/jeff89179/docker-domainmod.git
cd docker-domainmod
rm -rf docker-domainmod/domainmod       ### removes the pulled domainmod folder in favor of the current domainmod repo
                                        ### probably a better way to do this, but whatever
sudo git clone https://github.com/domainmod/domainmod.git

### Copy and update the config.inc.php file
cd domainmod
sudo cp config.SAMPLE.inc.php config.inc.php

### Update the config.inc.php file
sudo nano config.inc.php


// Path Settings
$web_root = '/dm'; // don't include trailing slash (if you're installing in the root just leave this blank)
            ### remove /dm from $web_root, otherwise you'll get an error during installation

// Database Settings
$dbhostname = 'localhost';       ### will have to be updated after the container is up I think - hence why I included nano
$dbname = 'db_name';             ### change to domainmod
$dbusername = 'db_username';     ### change to domainmod
$dbpassword = 'dbPassword123';   ### change to domainmod

### change directory back to docker-domainmod
cd ../..
pwd
should be back at /container-data/domainmod/docker-domainmod

### Create local image
docker build -f Dockerfile . -t domainmod-jeff89179:latest

### Bring up the docker containers with docker-compose, but don't start them, otherwise you'll be stuck in the log of it and have to stop them anyway with CTRL+C
docker-compose up --no-start

### Start the containers
docker start domainmod-mysql
docker start domainmod

### Find the IP of domainmod-mysql
docker inspect domainmod-mysql | grep '"IPAddress"'        ### in my case, it's 172.22.0.2

### SSH into domainmod and change config.inc.php so it reflects this IP as the dbhost
docker exec -it domainmod /bin/bash
cd _includes && nano config.inc.php
- update $dbhostname with the IP you got earlier
- ^X, y
- exit
- should be back at the docker host shell. No need to restart the container. 

### Thats it! Navigate to dockerhost.domain:8088 and follow the instructions to finish installation.

NOTE: I'm sure there is a way to set the network and IP in docker-compose.yml, but I leave that to you to figure out. 
Currently, there is no NetworkSolutions API support or CSV import support from the domainmod developer (as of April 2019), and I'm not going to import my domains one by one. So until domainmod gets updated with NetworkSolutions support or CSV import support, I have no plans to actually utilize this tool.
It has great potential - but for me, it's not quite there yet.
