# docker-domainmod
Domainmod under Docker

Forked from koshatul/docker-domainmod

### WARNING - THIS IS STILL A WORK IN PROGRESS! I HAD IT RUNNING PREVIOUSLY, THEN STARTED OVER TO MAKE THIS README, AND NOW IT WONT COME UP. STILL WORKING ON IT ###

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

### Bring up the docker containers with docker-compose 
docker-compose up

