#!/bin/bash

#  update and upgrade os
sudo apt-get update -y
sudo apt-get upgrade -y

# download nodejs setup script
pushd ~

curl -sL https://deb.nodesource.com/setup_7.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install nodejs -y
sudo apt-get install build-essential -y

popd

# make the nodejs server script executable
chmod +x ./server.js
chmod +x ./start_node.sh

# install PM2
sudo npm install -g pm2

# start service
pm2 start start_node.sh
pm2 start server.js

pm2 startup systemd

#  you need to change this. based on the  result of  pm2 startup systemd
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u jeff_tham --hp /home/jeff_tham
