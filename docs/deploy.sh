# Script to deploy the app
# This file is needed only when you want to deploy the app to a Linux VM

# install node
pushd .
cd ~
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt-get install nodejs -y
apt-get install build-essential -y

# install express
npm install express -y -g
popd

# configure nginx
rm -f /etc/nginx/sites-enabled/default
cp -f ./nginx-config /etc/nginx/sites-available/example
ln -fs /etc/nginx/sites-available/example /etc/nginx/sites-enabled
service nginx reload

# install pm2 and start the node server as a daemon
cd ..
npm install pm2 -g -y
pm2 delete example -s
pm2 start server.js -n example
