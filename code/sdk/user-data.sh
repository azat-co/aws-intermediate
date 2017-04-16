#!/bin/bash -ex
# user data to install node, download hello world server code and stat the app
# output user data logs into a separate place for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# get node into yum
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
# install node (and npm) with yum
yum -y install nodejs
# install pm2 to restart node app
npm i -g pm2@2.4.3
# get source code for hello world node server from GitHub's gist (could be private GitHub repo or private S3)
curl "https://gist.githubusercontent.com/azat-co/5c035301e13037e52cd689205b08c121/raw/e22a4606401ce63af715792b3fe50ef869b0557f/hello-world-server.js" > /home/ec2-user/hello-world-server.js
sudo chmod 755 /home/ec2-user/hello-world-server.js # optional
# restart pm2 and thus node app on reboot
crontab -l | { cat; echo "@reboot pm2 start /home/ec2-user/hello-world-server.js -i 0 --name \"node-app\""; } | crontab -
# start the server (port 3000)
pm2 start /home/ec2-user/hello-world-server.js -i 0 --name "node-app"
